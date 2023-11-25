(defsystem "cl-protohackers"
  :version "0.1.0"
  :author "Mike Delago"
  :license "BSD0"
  :depends-on ("usocket"
               "usocket-server"
               "serapeum"
               "alexandria"
               "log4cl-extras")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "cl-protohackers/tests"))))

(defsystem "cl-protohackers/tests"
  :author "Mike Delago"
  :license "BSD0"
  :depends-on ("cl-protohackers"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for cl-protohackers"
  :perform (test-op (op c) (symbol-call :rove :run c)))
