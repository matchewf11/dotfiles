return {
  current_datetime = {
    prefix = 'cdtm',
    body = '$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE $CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND',
    description = 'Insert current datetime (YYYY-mm-dd HH:MM:SS)',
  },
  current_date = {
    prefix = 'cdate',
    body = '$CURRENT_YEAR-$CURRENT_MONTH-$CURRENT_DATE',
    description = 'Insert current date (YYYY-mm-dd)',
  },
  current_time = {
    prefix = 'ctime',
    body = '$CURRENT_HOUR:$CURRENT_MINUTE:$CURRENT_SECOND',
    description = 'Insert current time (HH:MM:SS)',
  },
  email = {
    prefix = 'mail',
    body = 'matchewf11@gmail.com',
    description = 'My email',
  },
}

-- $1.. is the tabstops
-- $0 is the last one
-- ${1:placeholder}
-- ${1|a,b,c|} choices
-- {
--   "Basic":        { "prefix": "ba", "body": "T1=$1 T2=$2 T0=$0"         },
--   "Placeholders": { "prefix": "pl", "body": "T1=${1:aa}\nT2=${2:<$1>}"  },
--   "Choices":      { "prefix": "ch", "body": "T1=${1|a,b|} T2=${2|c,d|}" },
--   "Linked":       { "prefix": "li", "body": "T1=$1\n\tT1=$1"            },
--   "Variables":    { "prefix": "va", "body": "Runtime: $VIMRUNTIME\n"    },
--   "Complex":      {
--     "prefix": "co",
--     "body": [ "T1=${1:$RANDOM}", "T3=${3:$1_${2:$1}}", "T2=$2" ]
--   }
-- }
