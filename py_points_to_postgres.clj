;; Convert python point syntax to postgres point syntax
(ns python->postgres
  (:require [clojure.string :as str]))


(defn split-on-comma [s] (str/split s #","))

(defn is-point?
  "True iff s is a Python Point"
  [s] (or (re-matches
           #"\([+-]?([0-9]*[.])?[0-9]+ [+-]?([0-9]*[.])?[0-9]+\)"
           s)
          (re-matches
           #" \([+-]?([0-9]*[.])?[0-9]+ [+-]?([0-9]*[.])?[0-9]+\)"
           s)))

(defn py-pnt->postgres
  "Takes a string representing a Python Point and returns a string representing
   an equivalent PostgreSQL Point"
  [s] (str/replace (str/trim s) #" " ", "))

(defn py-pnts->postgres
  "Takes a string representing n Python Points and returns a string
   representing n equivalent PostgreSQL Points"
  [s]
  (str/join "\n" (map (partial str/join ", ")
                      (map (comp (partial map #(if (is-point? %)
                                                 (py-pnt->postgres %) %))
                                 split-on-comma) (str/split-lines s)))))
