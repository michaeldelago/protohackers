(defpackage cl-protohackers/tests/main
  (:use :cl
        :cl-protohackers
        :rove))
(in-package :cl-protohackers/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-protohackers)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))
