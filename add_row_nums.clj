(ns add-row-nums)

(defn prepend-rownum [starting-num s]
        (let [lines (clojure.string/split-lines s)
              row-nums (range starting-num (+ starting-num (count lines)))]
          (clojure.string/join "\n" (map
                                     (fn [row-num line] (str row-num "," line))
                                     row-nums
                                     lines))))
