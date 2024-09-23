

-- candidate table
CREATE TABLE candidate (
  cand_id VARCHAR(12) PRIMARY KEY,
  cand_nm VARCHAR(50)
);

-- contributor table
CREATE TABLE contributor (
  contbr_id INT AUTO_INCREMENT,
  contbr_nm VARCHAR(50),
  contbr_city VARCHAR(40),
  contbr_st VARCHAR(40),
  contbr_zip VARCHAR(20),
  contbr_employer VARCHAR(60),
  contbr_occupation VARCHAR(40),
  PRIMARY KEY (contbr_id)
);

-- contribution table
CREATE TABLE contribution (
  contb_id INT AUTO_INCREMENT PRIMARY KEY,
  cmte_id VARCHAR(12),
  cand_id VARCHAR(12),
  contbr_id INT,
  contb_receipt_amt NUMERIC(8, 2),
  contb_receipt_dt VARCHAR(20),
  receipt_desc VARCHAR(255),
  memo_cd VARCHAR(20),
  memo_text VARCHAR(255),
  form_tp VARCHAR(20),
  file_num VARCHAR(20),
  tran_id VARCHAR(20),
  election_tp VARCHAR(20),
  FOREIGN KEY (cand_id) REFERENCES candidate(cand_id),
  FOREIGN KEY (contbr_id) REFERENCES contributor(contbr_id)
);

CREATE INDEX contributor_nm ON contributor(contbr_nm);



-- Solutions to add to the text box

INSERT INTO candidate (cand_id, cand_nm)
SELECT DISTINCT cand_id, cand_nm
FROM campaign;

INSERT INTO contributor (contbr_nm, contbr_city, contbr_st, contbr_zip, contbr_employer, contbr_occupation)
SELECT DISTINCT contbr_nm, contbr_city, contbr_st, contbr_zip, contbr_employer, contbr_occupation
FROM campaign;

INSERT INTO contribution (cmte_id, cand_id, contbr_id, contb_receipt_amt, contb_receipt_dt, receipt_desc, memo_cd, memo_text, form_tp, file_num, tran_id, election_tp)
SELECT c.cmte_id, c.cand_id, co.contbr_id, c.contb_receipt_amt, c.contb_receipt_dt, c.receipt_desc, c.memo_cd, c.memo_text, c.form_tp, c.file_num, c.tran_id, c.election_tp
FROM campaign c
JOIN contributor co ON c.contbr_nm = co.contbr_nm
    AND c.contbr_city = co.contbr_city
    AND c.contbr_st = co.contbr_st
    AND c.contbr_zip = co.contbr_zip
    AND c.contbr_employer = co.contbr_employer
    AND c.contbr_occupation = co.contbr_occupation;

-- Create the view "vcampaign"
CREATE VIEW vcampaign AS
SELECT c.cand_nm AS cand_name,
       co.contbr_id,
       co.contbr_nm AS contbr_name,
       co.contbr_occupation AS occupation,
       co.contbr_city AS city,
       LEFT(co.contbr_zip, 5) AS zip,
       cn.contb_receipt_amt AS amount,
       cn.contb_receipt_dt AS date
FROM candidate c
JOIN contribution cn ON c.cand_id = cn.cand_id
JOIN contributor co ON cn.contbr_id = co.contbr_id;

-- Verify the row count using the view
SELECT COUNT(*) FROM vcampaign;

