(setq input (f-read-text "input.txt" 'utf-8))
(setq input-sequence (-map #'string-to-number (butlast (split-string input "\n"))))
(setq target 50047984)
;(setq target 127)

(defun get-subsequent-sequence-that-sums-to-target (target adding input)
  "Finds a subsequent list of numbers that add to the target value from the given input list"
                                        ; edge case
  (if (eq (length input) 0) nil (let ((adding-sum (-reduce #'+ adding)))
                                        ; base case
                                  (cond ((eq adding-sum target) adding)
                                        ; if too little, add a number to our subsequent list
                                        ((< adding-sum target)
                                         (get-subsequent-sequence-that-sums-to-target target (append
                                                                                              adding
                                                                                              (list
                                                                                               (car
                                                                                                input)))
                                                                                      (cdr input)))
                                        ; if too much, remove the first number from our subsequent list
                                        ((> adding-sum target)
                                         (get-subsequent-sequence-that-sums-to-target target (cdr
                                                                                              adding)
                                                                                      input))))))

(defun add-smallest-and-largest (sequence)
  "Finds the smallest two values in the input and adds them"
  (let* ((smallest (-min sequence))
         (rest (-remove-first (-partial #'equal smallest) sequence))
         (max (-max rest)))
    (+ smallest max)))


(setq max-specpdl-size 10000)
(setq max-lisp-eval-depth 10000)
(setq subsequent-sequence (get-subsequent-sequence-that-sums-to-target target (list)
                                                                       input-sequence))
(setq smallest-added (add-smallest-and-largest subsequent-sequence))
