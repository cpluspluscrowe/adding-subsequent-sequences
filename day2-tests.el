(ert-deftest
    get-subsequent-sequence-that-sums-to-target
    ()
  "Tests that the sequence builder works and returns the correct subsequent list"
                                        ; happy path
  (setq input (list 1 2 4))
  (setq target 3)
  (should (equal (get-subsequent-sequence-that-sums-to-target target (list) input)
                 (list 1 2)))
                                        ; case where we have to pop from the list
  (setq input (list 1 2 3 4))
  (setq target 5)
  (should (equal (get-subsequent-sequence-that-sums-to-target target (list) input)
                 (list 2 3))))

(ert-deftest
    add-smallest-and-largest
    ()
  "Tests to ensure the function gets the smallest two values and adds them"
  (should (equal (add-smallest-and-largest (list 1 3 4 1 2)) 5)))
