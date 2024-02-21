
addIoFiller -cell IOFILLERCELL64_ST_SF_LIN -prefix if64
addIoFiller -cell IOFILLERCELL32_ST_SF_LIN -prefix if32
addIoFiller -cell IOFILLER16_ST_SF_LIN -prefix if16
addIoFiller -cell IOFILLER8_ST_SF_LIN -prefix if8
addIoFiller -cell IOFILLER4_ST_SF_LIN -prefix if4
addIoFiller -cell IOFILLER2_ST_SF_LIN -prefix if2
addIoFiller -cell IOFILLER1_ST_SF_LIN -prefix if1

