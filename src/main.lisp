(defpackage cl-protohackers
  (:use :cl))
(in-package :cl-protohackers)

(log4cl-extras/config:setup
          '(:level :debug
            :appenders ((this-console :layout :json))))

(defun handle-connection (connection)
  (log4cl-extras/context:with-fields (:peer `(:address ,(usocket:host-to-hostname usocket:*remote-host*) :port ,usocket:*remote-port*))
    (handler-bind ((error
                     (lambda (c)
                       (log:warn "Client handler error: ~A~%" c)
                       (return-from handle-connection))))
      (loop do
            (let ((echo (read-line connection)))
              (log4cl-extras/context:with-fields (:input echo)
                (when (> (length echo) 0)
                  (log:info "received message")   
                  (format connection "~a~%" echo)
                  (force-output connection))))))))

(defvar *tcp-echo-thread* nil)
(defvar *tcp-echo-port* nil)

(defun create-server (&optional (ip usocket:*wildcard-host*) (port usocket:*auto-port*))
  (unless *tcp-echo-thread*
    (multiple-value-bind (thread socket)
      (usocket:socket-server ip port
                     'handle-connection nil
                     :protocol :stream
                     :in-new-thread t
                     :multi-threading t
                     :element-type 'character)
      (setq *tcp-echo-thread* thread
            *tcp-echo-port* (usocket:get-local-port socket)))))


(defun main ()
  (create-server nil 6969))



