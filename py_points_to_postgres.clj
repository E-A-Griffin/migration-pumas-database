(ns python->postgres
  (:require [clojure.string :as str]))


(defn split-on-comma [s] (str/split s #","))

(defn is-point? [s] (or (re-matches
                         #"\([+-]?([0-9]*[.])?[0-9]+ [+-]?([0-9]*[.])?[0-9]+\)"
                         s)
                        (re-matches
                         #" \([+-]?([0-9]*[.])?[0-9]+ [+-]?([0-9]*[.])?[0-9]+\)"
                         s)))

(defn py-pnt->postgres [s] (str/replace (str/trim s) #" " ", "))

(defn py-pnts->postgres [s] (str/join "\n" (map (partial str/join ", ") (map (comp (partial map #(if (is-point? %)
                                                                 (py-pnt->postgres %) %))
                                                 split-on-comma) (str/split-lines s)))))
