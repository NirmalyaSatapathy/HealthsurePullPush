use healthsure;
-- Insert 2 doctors
INSERT INTO Providers (
  provider_id, provider_name, hospital_name, telephone, email, password,
  address, city, state, zipcode, status, created_at
)
VALUES (
  'PROV001', 'Dr. Mehta', 'Sunrise Hospital', '022-12345678', 'mehta@sunrisehosp.com', 'hashed_provider_pw1',
  '123 MG Road', 'Mumbai', 'Maharashtra', '400001', 'APPROVED', CURRENT_TIMESTAMP
);
INSERT INTO Doctors (
  doctor_id, provider_id, doctor_name, qualification, specialization,
  license_no, email, phone_number, address, gender, doctor_type, doctor_status
)
VALUES
  ('DOC001', 'PROV001', 'Dr. Alice Smith',   'MD, Cardiology',    'Cardiologist',     'LIC001', 'alice.smith@hospital.com',   '9876543210', '123 Medical St, City',     'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC002', 'PROV001', 'Dr. Brian Lee',     'MD, Cardiology',    'Cardiologist',     'LIC002', 'brian.lee@hospital.com',     '9876543211', '456 Health Ave, City',     'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC003', 'PROV001', 'Dr. Carla Cruz',    'MD, Cardiology',    'Cardiologist',     'LIC003', 'carla.cruz@hospital.com',    '9876543212', '789 Care Blvd, City',      'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC004', 'PROV001', 'Dr. David Park',    'MD, Cardiology',    'Cardiologist',     'LIC004', 'david.park@hospital.com',    '9876543213', '321 Wellness Rd, City',    'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC005', 'PROV001', 'Dr. Eva Zhang',     'MD, Cardiology',    'Cardiologist',     'LIC005', 'eva.zhang@hospital.com',     '9876543214', '654 Healing St, City',     'FEMALE', 'STANDARD', 'ACTIVE'),

  ('DOC006', 'PROV001', 'Dr. Frank Miller',  'MD, Neurology',     'Neurologist',      'LIC006', 'frank.miller@hospital.com',  '9876543215', '123 Medical St, City',     'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC007', 'PROV001', 'Dr. Grace Kim',     'MD, Neurology',     'Neurologist',      'LIC007', 'grace.kim@hospital.com',     '9876543216', '456 Health Ave, City',     'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC008', 'PROV001', 'Dr. Henry Scott',   'MD, Neurology',     'Neurologist',      'LIC008', 'henry.scott@hospital.com',   '9876543217', '789 Care Blvd, City',      'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC009', 'PROV001', 'Dr. Irene Patel',   'MD, Neurology',     'Neurologist',      'LIC009', 'irene.patel@hospital.com',   '9876543218', '321 Wellness Rd, City',    'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC010', 'PROV001', 'Dr. Jack Owens',    'MD, Neurology',     'Neurologist',      'LIC010', 'jack.owens@hospital.com',    '9876543219', '654 Healing St, City',     'MALE',   'STANDARD', 'ACTIVE'),

  ('DOC011', 'PROV001', 'Dr. Karen Reed',    'MD, Pediatrics',    'Pediatrician',     'LIC011', 'karen.reed@hospital.com',    '9876543220', '123 Medical St, City',     'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC012', 'PROV001', 'Dr. Leo Ross',      'MD, Pediatrics',    'Pediatrician',     'LIC012', 'leo.ross@hospital.com',      '9876543221', '456 Health Ave, City',     'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC013', 'PROV001', 'Dr. Mia Torres',    'MD, Pediatrics',    'Pediatrician',     'LIC013', 'mia.torres@hospital.com',    '9876543222', '789 Care Blvd, City',      'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC014', 'PROV001', 'Dr. Noah Diaz',     'MD, Pediatrics',    'Pediatrician',     'LIC014', 'noah.diaz@hospital.com',     '9876543223', '321 Wellness Rd, City',    'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC015', 'PROV001', 'Dr. Olivia King',   'MD, Pediatrics',    'Pediatrician',     'LIC015', 'olivia.king@hospital.com',   '9876543224', '654 Healing St, City',     'FEMALE', 'STANDARD', 'ACTIVE'),

  ('DOC016', 'PROV001', 'Dr. Paul Wang',     'MD, Orthopedics',   'Orthopedic Surgeon','LIC016','paul.wang@hospital.com',     '9876543225', '123 Medical St, City',     'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC017', 'PROV001', 'Dr. Queen Allen',   'MD, Orthopedics',   'Orthopedic Surgeon','LIC017','queen.allen@hospital.com',   '9876543226', '456 Health Ave, City',     'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC018', 'PROV001', 'Dr. Ryan Young',    'MD, Orthopedics',   'Orthopedic Surgeon','LIC018','ryan.young@hospital.com',    '9876543227', '789 Care Blvd, City',      'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC019', 'PROV001', 'Dr. Sara Bell',     'MD, Orthopedics',   'Orthopedic Surgeon','LIC019','sara.bell@hospital.com',     '9876543228', '321 Wellness Rd, City',    'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC020', 'PROV001', 'Dr. Tom Brooks',    'MD, Orthopedics',   'Orthopedic Surgeon','LIC020','tom.brooks@hospital.com',    '9876543229', '654 Healing St, City',     'MALE',   'STANDARD', 'ACTIVE'),

  ('DOC021', 'PROV001', 'Dr. Uma Davis',     'MD, Dermatology',   'Dermatologist',    'LIC021', 'uma.davis@hospital.com',     '9876543230', '123 Medical St, City',     'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC022', 'PROV001', 'Dr. Victor Zhu',    'MD, Dermatology',   'Dermatologist',    'LIC022', 'victor.zhu@hospital.com',    '9876543231', '456 Health Ave, City',     'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC023', 'PROV001', 'Dr. Wendy Hill',    'MD, Dermatology',   'Dermatologist',    'LIC023', 'wendy.hill@hospital.com',    '9876543232', '789 Care Blvd, City',      'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC024', 'PROV001', 'Dr. Xavier Fox',    'MD, Dermatology',   'Dermatologist',    'LIC024', 'xavier.fox@hospital.com',    '9876543233', '321 Wellness Rd, City',    'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC025', 'PROV001', 'Dr. Yara Khan',     'MD, Dermatology',   'Dermatologist',    'LIC025', 'yara.khan@hospital.com',     '9876543234', '654 Healing St, City',     'FEMALE', 'STANDARD', 'ACTIVE'),

  ('DOC026', 'PROV001', 'Dr. Zachary Liu',   'MD, Endocrinology', 'Endocrinologist',  'LIC026', 'zachary.liu@hospital.com',   '9876543235', '123 Medical St, City',     'MALE',   'STANDARD', 'ACTIVE'),
  ('DOC027', 'PROV001', 'Dr. Abby Ross',     'MD, Endocrinology', 'Endocrinologist',  'LIC027', 'abby.ross@hospital.com',     '9876543236', '456 Health Ave, City',     'FEMALE', 'STANDARD', 'ACTIVE'),
  ('DOC028', 'PROV001', 'Dr. Ben Turner',    'MD, Endocrinology', 'Endocrinologist',  'LIC028', 'ben.turner@hospital.com',    '9876543237', '789 Care Blvd, City',      'MALE','STANDARD', 'ACTIVE');
-- Insert 10 patients
INSERT INTO Recipient (h_id, first_name, last_name, mobile, user_name, gender, dob, address, password, email, status)
VALUES
('HID001', 'John', 'Doe', '1234567890', 'johndoe', 'MALE', '1980-05-15', '123 Main St, City', 'hashed_pass1', 'nirmalyasuman@gmail.com', 'ACTIVE'),
('HID002', 'Jane', 'Smith', '2345678901', 'janesmith', 'FEMALE', '1985-08-20', '456 Oak Ave, Town', 'hashed_pass2', 'satapathynirmalya@gmail.com', 'ACTIVE'),
('HID003', 'Robert', 'Johnson', '3456789012', 'robertj', 'MALE', '1975-03-10', '789 Pine Rd, Village', 'hashed_pass3', 'sp.mishradevil@gmail.com', 'ACTIVE'),
('HID004', 'Sarah', 'Williams', '4567890123', 'sarahw', 'FEMALE', '1990-11-25', '321 Elm St, City', 'hashed_pass4', 'musicnirmalya@gmail.com', 'ACTIVE'),
('HID005', 'Michael', 'Brown', '5678901234', 'michaelb', 'MALE', '1988-07-30', '654 Maple Dr, Town', 'hashed_pass5', 'nirmalyaguddu177@gmail.com', 'ACTIVE');
-- Existing H001 to H005 are already inserted
-- Below are new recipients referenced in subscribed_members

INSERT INTO Recipient (h_id, first_name, last_name, mobile, user_name, gender, dob, address, password, email, status)
VALUES
('HID006', 'Mary', 'Doe', '1234500006', 'marydoe', 'FEMALE', '1984-06-01', '101 Maple St', 'hashed_pass6', 'mary.doe@email.com', 'ACTIVE'),
('HID007', 'Tom', 'Doe', '1234500007', 'tomdoe', 'MALE', '2006-03-12', '102 Maple St', 'hashed_pass7', 'tom.doe@email.com', 'ACTIVE'),
('HID008', 'Lisa', 'Doe', '1234500008', 'lisadoe', 'FEMALE', '2008-07-14', '103 Maple St', 'hashed_pass8', 'lisa.doe@email.com', 'ACTIVE'),
('HID009', 'Robert', 'Doe', '1234500009', 'robertdoe', 'MALE', '2012-09-20', '104 Maple St', 'hashed_pass9', 'robert.doe@email.com', 'ACTIVE'),
('HID010', 'Mary', 'Doe', '1234500010', 'marydoe2', 'FEMALE', '1984-06-01', '105 Maple St', 'hashed_pass10', 'mary2.doe@email.com', 'ACTIVE'),
('HID011', 'Tom', 'Doe', '1234500011', 'tomdoe2', 'MALE', '2006-03-12', '106 Maple St', 'hashed_pass11', 'tom2.doe@email.com', 'ACTIVE'),
('HID012', 'Lisa', 'Doe', '1234500012', 'lisadoe2', 'FEMALE', '2008-07-14', '107 Maple St', 'hashed_pass12', 'lisa2.doe@email.com', 'ACTIVE'),
('HID013', 'Michael', 'Smith', '1234500013', 'mikesmith', 'MALE', '1981-02-01', '108 Elm St', 'hashed_pass13', 'michael.smith@email.com', 'ACTIVE'),
('HID014', 'Emily', 'Smith', '1234500014', 'emilysmith', 'FEMALE', '2009-05-21', '109 Elm St', 'hashed_pass14', 'emily.smith@email.com', 'ACTIVE'),
('HID015', 'Daniel', 'Smith', '1234500015', 'danielsmith', 'MALE', '2014-08-18', '110 Elm St', 'hashed_pass15', 'daniel.smith@email.com', 'ACTIVE'),
('HID016', 'Michael', 'Smith', '1234500016', 'mikesmith2', 'MALE', '1981-02-01', '111 Elm St', 'hashed_pass16', 'michael2.smith@email.com', 'ACTIVE'),
('HID017', 'Emily', 'Smith', '1234500017', 'emilysmith2', 'FEMALE', '2009-05-21', '112 Elm St', 'hashed_pass17', 'emily2.smith@email.com', 'ACTIVE'),
('HID018', 'Daniel', 'Smith', '1234500018', 'danielsmith2', 'MALE', '2014-08-18', '113 Elm St', 'hashed_pass18', 'daniel2.smith@email.com', 'ACTIVE'),
('HID019', 'Sarah', 'Smith', '1234500019', 'sarahsmith', 'FEMALE', '1954-12-25', '114 Elm St', 'hashed_pass19', 'sarah.smith@email.com', 'ACTIVE'),
('HID020', 'Jennifer', 'Johnson', '1234500020', 'jennjohnson', 'FEMALE', '1979-03-15', '115 Pine Rd', 'hashed_pass20', 'jennifer.j@email.com', 'ACTIVE'),
('HID021', 'David', 'Johnson', '1234500021', 'davidjohnson', 'MALE', '2005-10-01', '116 Pine Rd', 'hashed_pass21', 'david.j@email.com', 'ACTIVE'),
('HID022', 'Olivia', 'Johnson', '1234500022', 'oliviajohnson', 'FEMALE', '2008-02-20', '117 Pine Rd', 'hashed_pass22', 'olivia.j@email.com', 'ACTIVE'),
('HID023', 'James', 'Williams', '1234500023', 'jamesw', 'MALE', '1989-11-11', '118 Birch St', 'hashed_pass23', 'james.w@email.com', 'ACTIVE'),
('HID024', 'Sophia', 'Williams', '1234500024', 'sophiaw', 'FEMALE', '2016-07-19', '119 Birch St', 'hashed_pass24', 'sophia.w@email.com', 'ACTIVE'),
('HID025', 'Liam', 'Williams', '1234500025', 'liamw', 'MALE', '2019-01-10', '120 Birch St', 'hashed_pass25', 'liam.w@email.com', 'ACTIVE'),
('HID026', 'Emma', 'Williams', '1234500026', 'emmaw', 'FEMALE', '2022-03-05', '121 Birch St', 'hashed_pass26', 'emma.w@email.com', 'ACTIVE'),
('HID027', 'Elizabeth', 'Brown', '1234500027', 'elizabethb', 'FEMALE', '1991-08-30', '122 Cedar Ln', 'hashed_pass27', 'elizabeth.b@email.com', 'ACTIVE'),
('HID028', 'Noah', 'Brown', '1234500028', 'noahb', 'MALE', '2014-04-17', '123 Cedar Ln', 'hashed_pass28', 'noah.b@email.com', 'ACTIVE'),
('HID029', 'Ava', 'Brown', '1234500029', 'avab', 'FEMALE', '2017-06-09', '124 Cedar Ln', 'hashed_pass29', 'ava.b@email.com', 'ACTIVE'),
('HID030', 'Elizabeth', 'Brown', '1234500030', 'elizabethb2', 'FEMALE', '1991-08-30', '125 Cedar Ln', 'hashed_pass30', 'elizabeth2.b@email.com', 'ACTIVE'),
('HID031', 'Noah', 'Brown', '1234500031', 'noahb2', 'MALE', '2014-04-17', '126 Cedar Ln', 'hashed_pass31', 'noah2.b@email.com', 'ACTIVE'),
('HID032', 'Ava', 'Brown', '1234500032', 'avab2', 'FEMALE', '2017-06-09', '127 Cedar Ln', 'hashed_pass32', 'ava2.b@email.com', 'ACTIVE'),
('HID033', 'William', 'Brown', '1234500033', 'williamb', 'MALE', '1956-11-21', '128 Cedar Ln', 'hashed_pass33', 'william.b@email.com', 'ACTIVE'),
('HID034', 'Grace', 'Brown', '1234500034', 'graceb', 'FEMALE', '1959-02-02', '129 Cedar Ln', 'hashed_pass34', 'grace.b@email.com', 'ACTIVE');

-- Insert insurance companies
INSERT INTO Insurance_company (company_id, name, logo_url, head_office, contact_email, contact_phone)
VALUES
('COMP001', 'HealthGuard', 'logo1.png', 'New York', 'contact@healthguard.com', '18001234567'),
('COMP002', 'LifeSecure', 'logo2.png', 'Chicago', 'info@lifesecure.com', '18009876543'),
('COMP003', 'WellCare', 'logo3.png', 'Los Angeles', 'support@wellcare.com', '18005556677');

-- Insert insurance plans (20 plans)
INSERT INTO Insurance_plan (plan_id, company_id, plan_name, plan_type, min_entry_age, max_entry_age, description, available_cover_amounts, waiting_period, periodic_diseases)
VALUES
('PLAN001', 'COMP001', 'HealthGuard Gold', 'SELF', 18, 65, 'Comprehensive individual coverage', '500000,1000000,2000000', '30 days', 'NO'),
('PLAN002', 'COMP001', 'HealthGuard Family', 'FAMILY', 18, 65, 'Family coverage for up to 10 members', '1000000,2000000,3000000', '30 days', 'NO'),
('PLAN003', 'COMP001', 'HealthGuard Senior', 'SENIOR', 50, 75, 'Special coverage for seniors', '300000,500000,1000000', '90 days', 'YES'),
('PLAN004', 'COMP002', 'LifeSecure Basic', 'SELF', 18, 60, 'Basic individual coverage', '300000,500000', '60 days', 'NO'),
('PLAN005', 'COMP002', 'LifeSecure Family Plus', 'FAMILY', 18, 60, 'Premium family coverage', '1500000,2500000', '60 days', 'NO'),
('PLAN006', 'COMP002', 'LifeSecure Critical', 'CRITICAL_ILLNESS', 25, 65, 'Critical illness coverage', '1000000,2000000', '180 days', 'YES'),
('PLAN007', 'COMP003', 'WellCare Standard', 'SELF', 20, 70, 'Standard individual plan', '400000,800000', '45 days', 'NO'),
('PLAN008', 'COMP003', 'WellCare Family', 'FAMILY', 20, 70, 'Standard family plan', '1200000,1800000', '45 days', 'NO'),
('PLAN009', 'COMP003', 'WellCare Senior Plus', 'SENIOR', 55, 80, 'Senior coverage with extra benefits', '500000,1000000', '90 days', 'YES'),
('PLAN010', 'COMP001', 'HealthGuard Platinum', 'SELF', 21, 65, 'Premium individual coverage', '1000000,2000000,3000000', '15 days', 'NO'),
('PLAN011', 'COMP001', 'HealthGuard Executive', 'FAMILY', 21, 65, 'Executive family coverage', '2000000,3000000,5000000', '15 days', 'NO'),
('PLAN012', 'COMP002', 'LifeSecure Gold', 'SELF', 18, 65, 'Gold level individual coverage', '750000,1500000', '30 days', 'NO'),
('PLAN013', 'COMP002', 'LifeSecure Silver', 'SELF', 18, 65, 'Silver level individual coverage', '500000,1000000', '30 days', 'NO'),
('PLAN014', 'COMP002', 'LifeSecure Bronze', 'SELF', 18, 65, 'Bronze level individual coverage', '250000,500000', '30 days', 'NO'),
('PLAN015', 'COMP003', 'WellCare Premium', 'SELF', 18, 70, 'Premium individual coverage', '1000000,2000000', '30 days', 'NO'),
('PLAN016', 'COMP003', 'WellCare Essential', 'SELF', 18, 70, 'Essential individual coverage', '300000,600000', '30 days', 'NO'),
('PLAN017', 'COMP003', 'WellCare Critical Plus', 'CRITICAL_ILLNESS', 30, 65, 'Enhanced critical illness coverage', '1500000,3000000', '120 days', 'YES'),
('PLAN018', 'COMP001', 'HealthGuard Critical', 'CRITICAL_ILLNESS', 25, 65, 'Critical illness coverage', '1000000,2000000', '120 days', 'YES'),
('PLAN019', 'COMP002', 'LifeSecure Senior', 'SENIOR', 50, 75, 'Senior coverage plan', '400000,800000', '90 days', 'YES'),
('PLAN020', 'COMP003', 'WellCare Family Plus', 'FAMILY', 20, 70, 'Enhanced family coverage', '1500000,2500000', '30 days', 'NO');
-- Insert coverage options (multiple per plan)
INSERT INTO Insurance_coverage_option (coverage_id, plan_id, premium_amount, coverage_amount)
VALUES
('COV001', 'PLAN001', 5000, 500000),
('COV002', 'PLAN001', 8000, 1000000),
('COV003', 'PLAN001', 12000, 2000000),
('COV004', 'PLAN002', 15000, 1000000),
('COV005', 'PLAN002', 22000, 2000000),
('COV006', 'PLAN002', 30000, 3000000),
('COV007', 'PLAN003', 10000, 300000),
('COV008', 'PLAN003', 15000, 500000),
('COV009', 'PLAN003', 25000, 1000000),
('COV010', 'PLAN004', 3000, 300000),
('COV011', 'PLAN004', 4500, 500000),
('COV012', 'PLAN005', 18000, 1500000),
('COV013', 'PLAN005', 28000, 2500000),
('COV014', 'PLAN006', 12000, 1000000),
('COV015', 'PLAN006', 20000, 2000000),
('COV016', 'PLAN007', 4000, 400000),
('COV017', 'PLAN007', 7000, 800000),
('COV018', 'PLAN008', 12000, 1200000),
('COV019', 'PLAN008', 16000, 1800000),
('COV020', 'PLAN009', 12000, 500000),
('COV021', 'PLAN009', 18000, 1000000),
('COV022', 'PLAN010', 10000, 1000000),
('COV023', 'PLAN010', 18000, 2000000),
('COV024', 'PLAN010', 25000, 3000000),
('COV025', 'PLAN011', 25000, 2000000),
('COV026', 'PLAN011', 35000, 3000000),
('COV027', 'PLAN011', 50000, 5000000),
('COV028', 'PLAN012', 7000, 750000),
('COV029', 'PLAN012', 12000, 1500000),
('COV030', 'PLAN013', 5000, 500000),
('COV031', 'PLAN013', 8000, 1000000),
('COV032', 'PLAN014', 3000, 250000),
('COV033', 'PLAN014', 4500, 500000),
('COV034', 'PLAN015', 10000, 1000000),
('COV035', 'PLAN015', 18000, 2000000),
('COV036', 'PLAN016', 3000, 300000),
('COV037', 'PLAN016', 5000, 600000),
('COV038', 'PLAN017', 15000, 1500000),
('COV039', 'PLAN017', 25000, 3000000),
('COV040', 'PLAN018', 12000, 1000000),
('COV041', 'PLAN018', 20000, 2000000),
('COV042', 'PLAN019', 10000, 400000),
('COV043', 'PLAN019', 15000, 800000),
('COV044', 'PLAN020', 20000, 1500000),
('COV045', 'PLAN020', 30000, 2500000);
-- Insert subscriptions for patients (5 patients with 20 plans each)
-- For H001 (20 plans - mix of individual and family)
-- For H001 (20 plans)
INSERT INTO subscribe (subscribe_id, h_id, coverage_id, subscribe_date, expiry_date, type, status, total_premium, amount_paid, start_date)
VALUES
('SUB001', 'HID001', 'COV001', '2023-01-01', '2024-01-01', 'INDIVIDUAL', 'ACTIVE', 5000, 5000, '2023-01-01'),
('SUB002', 'HID001', 'COV004', '2023-02-01', '2024-02-01', 'FAMILY', 'ACTIVE', 15000, 15000, '2023-02-01'),
('SUB003', 'HID001', 'COV007', '2023-03-01', '2024-03-01', 'INDIVIDUAL', 'ACTIVE', 10000, 10000, '2023-03-01'),
('SUB004', 'HID001', 'COV010', '2023-04-01', '2024-04-01', 'INDIVIDUAL', 'ACTIVE', 3000, 3000, '2023-04-01'),
('SUB005', 'HID001', 'COV012', '2023-05-01', '2024-05-01', 'FAMILY', 'ACTIVE', 18000, 18000, '2023-05-01'),
('SUB006', 'HID001', 'COV014', '2023-06-01', '2024-06-01', 'INDIVIDUAL', 'ACTIVE', 12000, 12000, '2023-06-01'),
('SUB007', 'HID001', 'COV016', '2023-07-01', '2024-07-01', 'INDIVIDUAL', 'ACTIVE', 4000, 4000, '2023-07-01'),
('SUB008', 'HID001', 'COV018', '2023-08-01', '2024-08-01', 'FAMILY', 'ACTIVE', 12000, 12000, '2023-08-01'),
('SUB009', 'HID001', 'COV020', '2023-09-01', '2024-09-01', 'INDIVIDUAL', 'ACTIVE', 12000, 12000, '2023-09-01'),
('SUB010', 'HID001', 'COV022', '2023-10-01', '2024-10-01', 'INDIVIDUAL', 'ACTIVE', 10000, 10000, '2023-10-01'),
('SUB011', 'HID001', 'COV025', '2023-11-01', '2024-11-01', 'FAMILY', 'ACTIVE', 25000, 25000, '2023-11-01'),
('SUB012', 'HID001', 'COV028', '2023-12-01', '2024-12-01', 'INDIVIDUAL', 'ACTIVE', 7000, 7000, '2023-12-01'),
('SUB013', 'HID001', 'COV030', '2024-01-01', '2025-01-01', 'INDIVIDUAL', 'ACTIVE', 5000, 5000, '2024-01-01'),
('SUB014', 'HID001', 'COV032', '2024-02-01', '2025-02-01', 'INDIVIDUAL', 'ACTIVE', 3000, 3000, '2024-02-01'),
('SUB015', 'HID001', 'COV034', '2024-03-01', '2025-03-01', 'INDIVIDUAL', 'ACTIVE', 10000, 10000, '2024-03-01'),
('SUB016', 'HID001', 'COV036', '2024-04-01', '2025-04-01', 'INDIVIDUAL', 'ACTIVE', 3000, 3000, '2024-04-01'),
('SUB017', 'HID001', 'COV038', '2024-05-01', '2025-05-01', 'INDIVIDUAL', 'ACTIVE', 15000, 15000, '2024-05-01'),
('SUB018', 'HID001', 'COV040', '2024-06-01', '2025-06-01', 'INDIVIDUAL', 'ACTIVE', 12000, 12000, '2024-06-01'),
('SUB019', 'HID001', 'COV042', '2024-07-01', '2025-07-01', 'INDIVIDUAL', 'ACTIVE', 10000, 10000, '2024-07-01'),
('SUB020', 'HID001', 'COV044', '2024-08-01', '2025-08-01', 'FAMILY', 'ACTIVE', 20000, 20000, '2024-08-01');

-- For H002 (20 plans)
INSERT INTO subscribe (subscribe_id, h_id, coverage_id, subscribe_date, expiry_date, type, status, total_premium, amount_paid, start_date)
VALUES
('SUB021', 'HID002', 'COV002', '2023-01-15', '2024-01-15', 'INDIVIDUAL', 'ACTIVE', 8000, 8000, '2023-01-15'),
('SUB022', 'HID002', 'COV005', '2023-02-15', '2024-02-15', 'FAMILY', 'ACTIVE', 22000, 22000, '2023-02-15'),
('SUB023', 'HID002', 'COV008', '2023-03-15', '2024-03-15', 'INDIVIDUAL', 'ACTIVE', 15000, 15000, '2023-03-15'),
('SUB024', 'HID002', 'COV011', '2023-04-15', '2024-04-15', 'INDIVIDUAL', 'ACTIVE', 4500, 4500, '2023-04-15'),
('SUB025', 'HID002', 'COV013', '2023-05-15', '2024-05-15', 'FAMILY', 'ACTIVE', 28000, 28000, '2023-05-15'),
('SUB026', 'HID002', 'COV015', '2023-06-15', '2024-06-15', 'INDIVIDUAL', 'ACTIVE', 20000, 20000, '2023-06-15'),
('SUB027', 'HID002', 'COV017', '2023-07-15', '2024-07-15', 'INDIVIDUAL', 'ACTIVE', 7000, 7000, '2023-07-15'),
('SUB028', 'HID002', 'COV019', '2023-08-15', '2024-08-15', 'FAMILY', 'ACTIVE', 16000, 16000, '2023-08-15'),
('SUB029', 'HID002', 'COV021', '2023-09-15', '2024-09-15', 'INDIVIDUAL', 'ACTIVE', 18000, 18000, '2023-09-15'),
('SUB030', 'HID002', 'COV023', '2023-10-15', '2024-10-15', 'INDIVIDUAL', 'ACTIVE', 18000, 18000, '2023-10-15'),
('SUB031', 'HID002', 'COV026', '2023-11-15', '2024-11-15', 'FAMILY', 'ACTIVE', 35000, 35000, '2023-11-15'),
('SUB032', 'HID002', 'COV029', '2023-12-15', '2024-12-15', 'INDIVIDUAL', 'ACTIVE', 12000, 12000, '2023-12-15'),
('SUB033', 'HID002', 'COV031', '2024-01-15', '2025-01-15', 'INDIVIDUAL', 'ACTIVE', 8000, 8000, '2024-01-15'),
('SUB034', 'HID002', 'COV033', '2024-02-15', '2025-02-15', 'INDIVIDUAL', 'ACTIVE', 4500, 4500, '2024-02-15'),
('SUB035', 'HID002', 'COV035', '2024-03-15', '2025-03-15', 'INDIVIDUAL', 'ACTIVE', 18000, 18000, '2024-03-15'),
('SUB036', 'HID002', 'COV037', '2024-04-15', '2025-04-15', 'INDIVIDUAL', 'ACTIVE', 5000, 5000, '2024-04-15'),
('SUB037', 'HID002', 'COV039', '2024-05-15', '2025-05-15', 'INDIVIDUAL', 'ACTIVE', 25000, 25000, '2024-05-15'),
('SUB038', 'HID002', 'COV041', '2024-06-15', '2025-06-15', 'INDIVIDUAL', 'ACTIVE', 20000, 20000, '2024-06-15'),
('SUB039', 'HID002', 'COV043', '2024-07-15', '2025-07-15', 'INDIVIDUAL', 'ACTIVE', 15000, 15000, '2024-07-15'),
('SUB040', 'HID002', 'COV045', '2024-08-15', '2025-08-15', 'FAMILY', 'ACTIVE', 30000, 30000, '2024-08-15');
INSERT INTO subscribe (subscribe_id, h_id, coverage_id, subscribe_date, expiry_date, type, status, total_premium, amount_paid, start_date)
VALUES
('SUB041', 'HID003', 'COV002', '2023-01-15', '2024-01-15', 'INDIVIDUAL', 'ACTIVE', 8000, 8000, '2023-01-15'),
('SUB042', 'HID003', 'COV005', '2023-02-15', '2024-02-15', 'INDIVIDUAL', 'ACTIVE', 22000, 22000, '2023-02-15'),
('SUB043', 'HID003', 'COV008', '2023-03-15', '2024-03-15', 'INDIVIDUAL', 'ACTIVE', 15000, 15000, '2023-03-15'),
('SUB044', 'HID003', 'COV011', '2023-04-15', '2024-04-15', 'INDIVIDUAL', 'ACTIVE', 4500, 4500, '2023-04-15'),
('SUB045', 'HID003', 'COV013', '2023-05-15', '2024-05-15', 'INDIVIDUAL', 'ACTIVE', 28000, 28000, '2023-05-15'),
('SUB046', 'HID003', 'COV015', '2023-06-15', '2024-06-15', 'INDIVIDUAL', 'ACTIVE', 20000, 20000, '2023-06-15'),
('SUB047', 'HID003', 'COV017', '2023-07-15', '2024-07-15', 'INDIVIDUAL', 'ACTIVE', 7000, 7000, '2023-07-15'),
('SUB048', 'HID003', 'COV019', '2023-08-15', '2024-08-15', 'INDIVIDUAL', 'ACTIVE', 16000, 16000, '2023-08-15'),
('SUB049', 'HID003', 'COV021', '2023-09-15', '2024-09-15', 'INDIVIDUAL', 'ACTIVE', 18000, 18000, '2023-09-15'),
('SUB050', 'HID003', 'COV023', '2023-10-15', '2024-10-15', 'INDIVIDUAL', 'ACTIVE', 18000, 18000, '2023-10-15'),
('SUB051', 'HID003', 'COV026', '2023-11-15', '2024-11-15', 'INDIVIDUAL', 'ACTIVE', 35000, 35000, '2023-11-15'),
('SUB052', 'HID003', 'COV029', '2023-12-15', '2024-12-15', 'INDIVIDUAL', 'ACTIVE', 12000, 12000, '2023-12-15'),
('SUB053', 'HID003', 'COV031', '2024-01-15', '2025-01-15', 'INDIVIDUAL', 'ACTIVE', 8000, 8000, '2024-01-15'),
('SUB054', 'HID003', 'COV033', '2024-02-15', '2025-02-15', 'INDIVIDUAL', 'ACTIVE', 4500, 4500, '2024-02-15'),
('SUB055', 'HID003', 'COV035', '2024-03-15', '2025-03-15', 'INDIVIDUAL', 'ACTIVE', 18000, 18000, '2024-03-15'),
('SUB056', 'HID003', 'COV037', '2024-04-15', '2025-04-15', 'INDIVIDUAL', 'ACTIVE', 5000, 5000, '2024-04-15'),
('SUB057', 'HID003', 'COV039', '2024-05-15', '2025-05-15', 'INDIVIDUAL', 'ACTIVE', 25000, 25000, '2024-05-15'),
('SUB058', 'HID003', 'COV041', '2024-06-15', '2025-06-15', 'INDIVIDUAL', 'ACTIVE', 20000, 20000, '2024-06-15'),
('SUB059', 'HID003', 'COV043', '2024-07-15', '2025-07-15', 'INDIVIDUAL', 'ACTIVE', 15000, 15000, '2024-07-15'),
('SUB060', 'HID003', 'COV045', '2024-08-15', '2025-08-15', 'INDIVIDUAL', 'ACTIVE', 30000, 30000, '2024-08-15');
-- INSERT INTO subscribed_members table
-- Family plans for H001
-- Family plans for H001
INSERT INTO subscribed_members (member_id, subscribe_id, h_id, full_name, age, gender, relation_with_proposer, aadhar_no) VALUES
-- SUB002 (Family plan)
('MEM001', 'SUB002', 'HID001', 'John Doe', 43, 'MALE', 'SELF', '769152153246'),
('MEM002', 'SUB002', 'HID006', 'Mary Doe', 40, 'FEMALE', 'SPOUSE', '127344634377'),
('MEM003', 'SUB002', 'HID007', 'Tom Doe', 18, 'MALE', 'CHILD', '180093187563'),
('MEM004', 'SUB002', 'HID008', 'Lisa Doe', 16, 'FEMALE', 'CHILD', '687082469699'),
('MEM005', 'SUB002', 'HID009', 'Robert Doe', 12, 'MALE', 'CHILD', '212108007118'),

-- SUB005 (Family plan)
('MEM006', 'SUB005', 'HID001', 'John Doe', 43, 'MALE', 'SELF', '769152153246'),
('MEM007', 'SUB005', 'HID006', 'Mary Doe', 40, 'FEMALE', 'SPOUSE', '127344634377'),
('MEM008', 'SUB005', 'HID007', 'Tom Doe', 18, 'MALE', 'CHILD', '180093187563'),
('MEM009', 'SUB005', 'HID008', 'Lisa Doe', 16, 'FEMALE', 'CHILD', '687082469699'),
('MEM010', 'SUB005', 'HID009', 'Robert Doe', 12, 'MALE', 'CHILD', '212108007118'),

-- SUB008 (Family plan)
('MEM011', 'SUB008', 'HID001', 'John Doe', 43, 'MALE', 'SELF', '769152153246'),
('MEM012', 'SUB008', 'HID006', 'Mary Doe', 40, 'FEMALE', 'SPOUSE', '127344634377'),
('MEM013', 'SUB008', 'HID007', 'Tom Doe', 18, 'MALE', 'CHILD', '180093187563'),
('MEM014', 'SUB008', 'HID008', 'Lisa Doe', 16, 'FEMALE', 'CHILD', '687082469699'),
('MEM015', 'SUB008', 'HID009', 'Robert Doe', 12, 'MALE', 'CHILD', '212108007118'),

-- SUB011 (Family plan)
('MEM016', 'SUB011', 'HID001', 'John Doe', 43, 'MALE', 'SELF', '769152153246'),
('MEM017', 'SUB011', 'HID006', 'Mary Doe', 40, 'FEMALE', 'SPOUSE', '127344634377'),
('MEM018', 'SUB011', 'HID007', 'Tom Doe', 18, 'MALE', 'CHILD', '180093187563'),
('MEM019', 'SUB011', 'HID008', 'Lisa Doe', 16, 'FEMALE', 'CHILD', '687082469699'),
('MEM020', 'SUB011', 'HID009', 'Robert Doe', 12, 'MALE', 'CHILD', '212108007118'),

-- SUB020 (Family plan)
('MEM021', 'SUB020', 'HID001', 'John Doe', 43, 'MALE', 'SELF', '769152153246'),
('MEM022', 'SUB020', 'HID006', 'Mary Doe', 40, 'FEMALE', 'SPOUSE', '127344634377'),
('MEM023', 'SUB020', 'HID007', 'Tom Doe', 18, 'MALE', 'CHILD', '180093187563'),
('MEM024', 'SUB020', 'HID008', 'Lisa Doe', 16, 'FEMALE', 'CHILD', '687082469699'),
('MEM025', 'SUB020', 'HID009', 'Robert Doe', 12, 'MALE', 'CHILD', '212108007118');

-- Family plans for H002
INSERT INTO subscribed_members (member_id, subscribe_id, h_id, full_name, age, gender, relation_with_proposer, aadhar_no) VALUES
-- SUB022 (Family plan)
('MEM026', 'SUB022', 'HID002', 'Jane Smith', 38, 'FEMALE', 'SELF', '235002354238'),
('MEM027', 'SUB022', 'HID013', 'Michael Smith', 42, 'MALE', 'SPOUSE', '257938721339'),
('MEM028', 'SUB022', 'HID014', 'Emily Smith', 15, 'FEMALE', 'CHILD', '613943723840'),
('MEM029', 'SUB022', 'HID015', 'Daniel Smith', 10, 'MALE', 'CHILD', '258080496934'),

-- SUB025 (Family plan)
('MEM030', 'SUB025', 'HID002', 'Jane Smith', 38, 'FEMALE', 'SELF', '235002354238'),
('MEM031', 'SUB025', 'HID013', 'Michael Smith', 42, 'MALE', 'SPOUSE', '257938721339'),
('MEM032', 'SUB025', 'HID014', 'Emily Smith', 15, 'FEMALE', 'CHILD', '613943723840'),
('MEM033', 'SUB025', 'HID015', 'Daniel Smith', 10, 'MALE', 'CHILD', '258080496934'),
('MEM034', 'SUB025', 'HID019', 'Sarah Smith', 70, 'FEMALE', 'PARENT', '119711051617'),

-- SUB028 (Family plan)
('MEM035', 'SUB028', 'HID002', 'Jane Smith', 38, 'FEMALE', 'SELF', '235002354238'),
('MEM036', 'SUB028', 'HID016', 'Michael Smith', 42, 'MALE', 'SPOUSE', '239934660921'),
('MEM037', 'SUB028', 'HID017', 'Emily Smith', 15, 'FEMALE', 'CHILD', '709746043759'),
('MEM038', 'SUB028', 'HID018', 'Daniel Smith', 10, 'MALE', 'CHILD', '692302598211'),

-- SUB031 (Family plan)
('MEM039', 'SUB031', 'HID002', 'Jane Smith', 38, 'FEMALE', 'SELF', '235002354238'),
('MEM040', 'SUB031', 'HID013', 'Michael Smith', 42, 'MALE', 'SPOUSE', '257938721339'),
('MEM041', 'SUB031', 'HID014', 'Emily Smith', 15, 'FEMALE', 'CHILD', '613943723840'),
('MEM042', 'SUB031', 'HID015', 'Daniel Smith', 10, 'MALE', 'CHILD', '258080496934'),
('MEM043', 'SUB031', 'HID019', 'Sarah Smith', 70, 'FEMALE', 'PARENT', '119711051617'),

-- SUB040 (Family plan)
('MEM044', 'SUB040', 'HID002', 'Jane Smith', 38, 'FEMALE', 'SELF', '235002354238'),
('MEM045', 'SUB040', 'HID016', 'Michael Smith', 42, 'MALE', 'SPOUSE', '239934660921'),
('MEM046', 'SUB040', 'HID017', 'Emily Smith', 15, 'FEMALE', 'CHILD', '709746043759'),
('MEM047', 'SUB040', 'HID018', 'Daniel Smith', 10, 'MALE', 'CHILD', '692302598211'),
('MEM048', 'SUB040', 'HID019', 'Sarah Smith', 70, 'FEMALE', 'PARENT', '119711051617');

INSERT INTO Doctor_availability (
  availability_id, doctor_id, available_date, start_time, end_time,
  slot_type, total_slots, is_recurring, notes
)
VALUES
('AVAIL001', 'DOC001', '2023-10-15', '09:00:00', '17:00:00', 'STANDARD', 16, FALSE, 'Regular schedule'),
('AVAIL002', 'DOC001', '2023-10-16', '09:00:00', '17:00:00', 'STANDARD', 16, TRUE, 'Regular schedule'),
('AVAIL003', 'DOC002', '2023-10-15', '10:00:00', '18:00:00', 'STANDARD', 16, FALSE, 'Regular schedule'),
('AVAIL004', 'DOC002', '2023-10-16', '10:00:00', '18:00:00', 'STANDARD', 16, TRUE, 'Regular schedule');

-- Insert appointments for patients with both doctors
INSERT INTO Appointment (
  appointment_id,
  doctor_id,
  h_id,
  availability_id,
  provider_id,
  booked_at,
  status,
  slot_no,
  start,
  end
) VALUES
  ('APP001', 'DOC001', 'HID001', 'AVAIL001', 'PROV001', '2023-10-10 10:00:00', 'BOOKED', 1, '2023-10-10 10:00:00', '2023-10-10 10:30:00'),
  ('APP002', 'DOC001', 'HID002', 'AVAIL001', 'PROV001', '2023-10-10 10:30:00', 'BOOKED', 2, '2023-10-10 10:30:00', '2023-10-10 11:00:00'),
  ('APP003', 'DOC001', 'HID003', 'AVAIL001', 'PROV001', '2023-10-10 11:00:00', 'BOOKED', 3, '2023-10-10 11:00:00', '2023-10-10 11:30:00'),
  ('APP004', 'DOC001', 'HID004', 'AVAIL001', 'PROV001', '2023-10-10 11:30:00', 'BOOKED', 4, '2023-10-10 11:30:00', '2023-10-10 12:00:00'),
  ('APP005', 'DOC001', 'HID005', 'AVAIL001', 'PROV001', '2023-10-10 12:00:00', 'BOOKED', 5, '2023-10-10 12:00:00', '2023-10-10 12:30:00'),
  ('APP006', 'DOC001', 'HID006', 'AVAIL001', 'PROV001', '2023-10-10 12:30:00', 'BOOKED', 6, '2023-10-10 12:30:00', '2023-10-10 13:00:00'),
  ('APP007', 'DOC001', 'HID007', 'AVAIL001', 'PROV001', '2023-10-10 13:00:00', 'BOOKED', 7, '2023-10-10 13:00:00', '2023-10-10 13:30:00'),
  ('APP008', 'DOC001', 'HID008', 'AVAIL002', 'PROV001', '2023-10-11 10:00:00', 'BOOKED', 1, '2023-10-11 10:00:00', '2023-10-11 10:30:00'),
  ('APP009', 'DOC001', 'HID009', 'AVAIL002', 'PROV001', '2023-10-11 10:30:00', 'BOOKED', 2, '2023-10-11 10:30:00', '2023-10-11 11:00:00'),
  ('APP010', 'DOC001', 'HID010', 'AVAIL002', 'PROV001', '2023-10-11 11:00:00', 'BOOKED', 3, '2023-10-11 11:00:00', '2023-10-11 11:30:00'),
  ('APP021', 'DOC001', 'HID011', 'AVAIL002', 'PROV001', '2023-10-11 11:30:00', 'BOOKED', 4, '2023-10-11 11:30:00', '2023-10-11 12:00:00'),
  ('APP022', 'DOC001', 'HID012', 'AVAIL002', 'PROV001', '2023-10-11 12:00:00', 'BOOKED', 5, '2023-10-11 12:00:00', '2023-10-11 12:30:00'),
  ('APP023', 'DOC001', 'HID013', 'AVAIL002', 'PROV001', '2023-10-11 12:30:00', 'BOOKED', 6, '2023-10-11 12:30:00', '2023-10-11 13:00:00'),
  ('APP024', 'DOC001', 'HID014', 'AVAIL002', 'PROV001', '2023-10-11 13:00:00', 'BOOKED', 7, '2023-10-11 13:00:00', '2023-10-11 13:30:00'),
  ('APP025', 'DOC001', 'HID015', 'AVAIL002', 'PROV001', '2023-10-11 13:30:00', 'BOOKED', 8, '2023-10-11 13:30:00', '2023-10-11 14:00:00'),
  ('APP026', 'DOC001', 'HID016', 'AVAIL002', 'PROV001', '2023-10-11 14:00:00', 'BOOKED', 9, '2023-10-11 14:00:00', '2023-10-11 14:30:00'),
  ('APP027', 'DOC001', 'HID017', 'AVAIL002', 'PROV001', '2023-10-11 14:30:00', 'BOOKED', 10, '2023-10-11 14:30:00', '2023-10-11 15:00:00'),
  ('APP028', 'DOC001', 'HID018', 'AVAIL002', 'PROV001', '2023-10-11 15:00:00', 'BOOKED', 11, '2023-10-11 15:00:00', '2023-10-11 15:30:00'),
  ('APP029', 'DOC001', 'HID019', 'AVAIL002', 'PROV001', '2023-10-11 15:30:00', 'BOOKED', 12, '2023-10-11 15:30:00', '2023-10-11 16:00:00');
INSERT INTO Appointment (
  appointment_id,
  doctor_id,
  h_id,
  availability_id,
  provider_id,
  booked_at,
  status,
  slot_no,
  start,
  end
) VALUES
  ('APP011', 'DOC002', 'HID001', 'AVAIL003', 'PROV001', '2023-10-10 10:00:00', 'BOOKED', 1, '2023-10-10 10:00:00', '2023-10-10 10:30:00'),
  ('APP012', 'DOC002', 'HID002', 'AVAIL003', 'PROV001', '2023-10-10 10:30:00', 'BOOKED', 2, '2023-10-10 10:30:00', '2023-10-10 11:00:00'),
  ('APP013', 'DOC002', 'HID003', 'AVAIL003', 'PROV001', '2023-10-10 11:00:00', 'BOOKED', 3, '2023-10-10 11:00:00', '2023-10-10 11:30:00'),
  ('APP014', 'DOC002', 'HID004', 'AVAIL003', 'PROV001', '2023-10-10 11:30:00', 'BOOKED', 4, '2023-10-10 11:30:00', '2023-10-10 12:00:00'),
  ('APP015', 'DOC002', 'HID005', 'AVAIL003', 'PROV001', '2023-10-10 12:00:00', 'BOOKED', 5, '2023-10-10 12:00:00', '2023-10-10 12:30:00'),
  ('APP016', 'DOC002', 'HID006', 'AVAIL003', 'PROV001', '2023-10-10 12:30:00', 'BOOKED', 6, '2023-10-10 12:30:00', '2023-10-10 13:00:00'),
  ('APP017', 'DOC002', 'HID007', 'AVAIL003', 'PROV001', '2023-10-10 13:00:00', 'BOOKED', 7, '2023-10-10 13:00:00', '2023-10-10 13:30:00'),
  ('APP018', 'DOC002', 'HID008', 'AVAIL004', 'PROV001', '2023-10-11 10:00:00', 'BOOKED', 1, '2023-10-11 10:00:00', '2023-10-11 10:30:00'),
  ('APP019', 'DOC002', 'HID009', 'AVAIL004', 'PROV001', '2023-10-11 10:30:00', 'BOOKED', 2, '2023-10-11 10:30:00', '2023-10-11 11:00:00'),
  ('APP020', 'DOC002', 'HID010', 'AVAIL004', 'PROV001', '2023-10-11 11:00:00', 'BOOKED', 3, '2023-10-11 11:00:00', '2023-10-11 11:30:00'),
  ('APP030', 'DOC002', 'HID011', 'AVAIL004', 'PROV001', '2023-10-11 11:30:00', 'BOOKED', 4, '2023-10-11 11:30:00', '2023-10-11 12:00:00'),
  ('APP031', 'DOC002', 'HID012', 'AVAIL004', 'PROV001', '2023-10-11 12:00:00', 'BOOKED', 5, '2023-10-11 12:00:00', '2023-10-11 12:30:00'),
  ('APP032', 'DOC002', 'HID013', 'AVAIL004', 'PROV001', '2023-10-11 12:30:00', 'BOOKED', 6, '2023-10-11 12:30:00', '2023-10-11 13:00:00'),
  ('APP033', 'DOC002', 'HID014', 'AVAIL004', 'PROV001', '2023-10-11 13:00:00', 'BOOKED', 7, '2023-10-11 13:00:00', '2023-10-11 13:30:00'),
  ('APP034', 'DOC002', 'HID015', 'AVAIL004', 'PROV001', '2023-10-11 13:30:00', 'BOOKED', 8, '2023-10-11 13:30:00', '2023-10-11 14:00:00'),
  ('APP035', 'DOC002', 'HID016', 'AVAIL004', 'PROV001', '2023-10-11 14:00:00', 'BOOKED', 9, '2023-10-11 14:00:00', '2023-10-11 14:30:00'),
  ('APP036', 'DOC002', 'HID017', 'AVAIL004', 'PROV001', '2023-10-11 14:30:00', 'BOOKED', 10, '2023-10-11 14:30:00', '2023-10-11 15:00:00'),
  ('APP037', 'DOC002', 'HID018', 'AVAIL004', 'PROV001', '2023-10-11 15:00:00', 'BOOKED', 11, '2023-10-11 15:00:00', '2023-10-11 15:30:00'),
  ('APP038', 'DOC002', 'HID019', 'AVAIL004', 'PROV001', '2023-10-11 15:30:00', 'BOOKED', 12, '2023-10-11 15:30:00', '2023-10-11 16:00:00');
-- Insert medical procedures
INSERT INTO medical_procedure (procedure_id, appointment_id, h_id, provider_id, doctor_id, procedure_date, diagnosis, recommendations, procedure_type, procedure_status)
VALUES
('PROC001', 'APP001', 'HID001', 'PROV001', 'DOC001', '2023-10-15', 'Hypertension', 'Medication and lifestyle changes', 'LONG_TERM', 'IN_PROGRESS'),
('PROC002', 'APP002', 'HID002', 'PROV001', 'DOC001', '2023-10-15', 'High cholesterol', 'Diet modification and statins', 'LONG_TERM', 'IN_PROGRESS'),
('PROC003', 'APP003', 'HID003', 'PROV001', 'DOC001', '2023-10-15', 'Type 2 Diabetes', 'Insulin therapy and monitoring', 'LONG_TERM', 'IN_PROGRESS'),
('PROC004', 'APP004', 'HID004', 'PROV001', 'DOC001', '2023-10-15', 'Coronary artery disease', 'Angioplasty recommended', 'LONG_TERM', 'IN_PROGRESS'),
('PROC005', 'APP005', 'HID005', 'PROV001', 'DOC001', '2023-10-15', 'Arrhythmia', 'Beta blockers prescribed', 'LONG_TERM', 'IN_PROGRESS'),
('PROC006', 'APP006', 'HID006', 'PROV001', 'DOC001', '2023-10-15', 'Asthma', 'Inhalers and allergy testing', 'LONG_TERM', 'IN_PROGRESS'),
('PROC007', 'APP007', 'HID007', 'PROV001', 'DOC001', '2023-10-15', 'Heart failure', 'Diuretics and ACE inhibitors', 'LONG_TERM', 'IN_PROGRESS'),
('PROC008', 'APP008', 'HID008', 'PROV001', 'DOC001', '2023-10-16', 'Angina', 'Nitroglycerin and stress test', 'LONG_TERM', 'IN_PROGRESS'),
('PROC009', 'APP009', 'HID009', 'PROV001', 'DOC001', '2023-10-16', 'Peripheral artery disease', 'Exercise and medication', 'LONG_TERM', 'IN_PROGRESS'),
('PROC010', 'APP010', 'HID010', 'PROV001', 'DOC001', '2023-10-16', 'Atrial fibrillation', 'Blood thinners prescribed', 'LONG_TERM', 'IN_PROGRESS'),
('PROC011', 'APP011', 'HID001', 'PROV001', 'DOC002', '2023-10-15', 'Childhood vaccinations', 'Completed routine immunization', 'LONG_TERM', 'IN_PROGRESS'),
('PROC012', 'APP012', 'HID002', 'PROV001', 'DOC002', '2023-10-15', 'Pediatric checkup', 'Normal development', 'LONG_TERM', 'IN_PROGRESS'),
('PROC013', 'APP013', 'HID003', 'PROV001', 'DOC002', '2023-10-15', 'Ear infection', 'Antibiotics prescribed', 'LONG_TERM', 'IN_PROGRESS'),
('PROC014', 'APP014', 'HID004', 'PROV001', 'DOC002', '2023-10-15', 'Allergy testing', 'Identified pollen allergy', 'LONG_TERM', 'IN_PROGRESS'),
('PROC015', 'APP015', 'HID005', 'PROV001', 'DOC002', '2023-10-15', 'Well-baby visit', 'Growth on track', 'LONG_TERM', 'IN_PROGRESS'),
('PROC016', 'APP016', 'HID006', 'PROV001', 'DOC002', '2023-10-15', 'ADHD evaluation', 'Behavioral therapy recommended', 'LONG_TERM', 'IN_PROGRESS'),
('PROC017', 'APP017', 'HID007', 'PROV001', 'DOC002', '2023-10-15', 'Asthma management', 'Inhaler technique reviewed', 'LONG_TERM', 'IN_PROGRESS'),
('PROC018', 'APP018', 'HID008', 'PROV001', 'DOC002', '2023-10-16', 'Sports physical', 'Cleared for participation', 'LONG_TERM', 'IN_PROGRESS'),
('PROC019', 'APP019', 'HID009', 'PROV001', 'DOC002', '2023-10-16', 'Nutrition counseling', 'Diet plan provided', 'LONG_TERM', 'IN_PROGRESS'),
('PROC020', 'APP020', 'HID010', 'PROV001', 'DOC002', '2023-10-16', 'Developmental screening', 'Normal milestones achieved', 'LONG_TERM', 'IN_PROGRESS');
-- Single-day procedures IN_PROGRESS (25 rows)
INSERT INTO medical_procedure (procedure_id, appointment_id, h_id, provider_id, doctor_id, procedure_date, diagnosis, recommendations, procedure_type, procedure_status) VALUES
('PROC021', 'APP001', 'HID001', 'PROV001', 'DOC001', '2023-10-17', 'Hypertension follow-up', 'Continue medication, reduce salt intake', 'LONG_TERM', 'IN_PROGRESS'),
('PROC022', 'APP002', 'HID002', 'PROV001', 'DOC001', '2023-10-17', 'Cholesterol check', 'Continue statins, increase exercise', 'LONG_TERM', 'IN_PROGRESS'),
('PROC023', 'APP003', 'HID003', 'PROV001', 'DOC001', '2023-10-17', 'Diabetes management', 'Adjust insulin dosage', 'LONG_TERM', 'IN_PROGRESS'),
('PROC024', 'APP004', 'HID004', 'PROV001', 'DOC001', '2023-10-17', 'Post-angioplasty check', 'Monitor for complications', 'LONG_TERM', 'IN_PROGRESS'),
('PROC025', 'APP005', 'HID005', 'PROV001', 'DOC001', '2023-10-17', 'Arrhythmia monitoring', 'Continue beta blockers', 'LONG_TERM', 'IN_PROGRESS'),
('PROC026', 'APP006', 'HID006', 'PROV001', 'DOC001', '2023-10-17', 'Asthma exacerbation', 'Increase inhaler use temporarily', 'LONG_TERM', 'IN_PROGRESS'),
('PROC027', 'APP007', 'HID007', 'PROV001', 'DOC001', '2023-10-17', 'Heart failure assessment', 'Adjust diuretics dosage', 'LONG_TERM', 'IN_PROGRESS'),
('PROC028', 'APP008', 'HID008', 'PROV001', 'DOC001', '2023-10-17', 'Angina evaluation', 'Consider stress test', 'LONG_TERM', 'IN_PROGRESS'),
('PROC029', 'APP009', 'HID009', 'PROV001', 'DOC001', '2023-10-17', 'PAD follow-up', 'Monitor walking tolerance', 'LONG_TERM', 'IN_PROGRESS'),
('PROC030', 'APP010', 'HID010', 'PROV001', 'DOC001', '2023-10-17', 'AFib management', 'Check INR levels', 'LONG_TERM', 'IN_PROGRESS'),
('PROC031', 'APP011', 'HID001', 'PROV001', 'DOC002', '2023-10-17', 'Pediatric vaccination', 'Administer flu vaccine', 'LONG_TERM', 'IN_PROGRESS'),
('PROC032', 'APP012', 'HID002', 'PROV001', 'DOC002', '2023-10-17', 'Child wellness check', 'Assess growth milestones', 'LONG_TERM', 'IN_PROGRESS'),
('PROC033', 'APP013', 'HID003', 'PROV001', 'DOC002', '2023-10-17', 'Ear infection follow-up', 'Check for resolution', 'LONG_TERM', 'IN_PROGRESS'),
('PROC034', 'APP014', 'HID004', 'PROV001', 'DOC002', '2023-10-17', 'Allergy follow-up', 'Evaluate immunotherapy options', 'LONG_TERM', 'IN_PROGRESS'),
('PROC035', 'APP015', 'HID005', 'PROV001', 'DOC002', '2023-10-17', 'Infant wellness', 'Discuss feeding schedule', 'LONG_TERM', 'IN_PROGRESS'),
('PROC036', 'APP016', 'HID006', 'PROV001', 'DOC002', '2023-10-17', 'ADHD medication review', 'Adjust dosage as needed', 'LONG_TERM', 'IN_PROGRESS'),
('PROC037', 'APP017', 'HID007', 'PROV001', 'DOC002', '2023-10-17', 'Asthma control', 'Review peak flow readings', 'LONG_TERM', 'IN_PROGRESS'),
('PROC038', 'APP018', 'HID008', 'PROV001', 'DOC002', '2023-10-17', 'Sports injury', 'Evaluate ankle sprain', 'LONG_TERM', 'IN_PROGRESS'),
('PROC039', 'APP019', 'HID009', 'PROV001', 'DOC002', '2023-10-17', 'Nutrition follow-up', 'Review dietary changes', 'LONG_TERM', 'IN_PROGRESS'),
('PROC040', 'APP020', 'HID010', 'PROV001', 'DOC002', '2023-10-17', 'Developmental assessment', 'Evaluate speech progress', 'LONG_TERM', 'IN_PROGRESS'),
('PROC041', 'APP001', 'HID001', 'PROV001', 'DOC001', '2023-10-18', 'Hypertension crisis', 'Emergency blood pressure management', 'LONG_TERM', 'IN_PROGRESS'),
('PROC042', 'APP002', 'HID002', 'PROV001', 'DOC001', '2023-10-18', 'Lipid panel review', 'Discuss results', 'LONG_TERM', 'IN_PROGRESS'),
('PROC043', 'APP003', 'HID003', 'PROV001', 'DOC001', '2023-10-18', 'Diabetes education', 'Carb counting session', 'LONG_TERM', 'IN_PROGRESS'),
('PROC044', 'APP004', 'HID004', 'PROV001', 'DOC001', '2023-10-18', 'Cardiac rehab session', 'Supervised exercise', 'LONG_TERM', 'IN_PROGRESS'),
('PROC045', 'APP005', 'HID005', 'PROV001', 'DOC001', '2023-10-18', 'Arrhythmia episode', 'Emergency EKG', 'LONG_TERM', 'IN_PROGRESS');

-- Long-term procedures IN_PROGRESS (10 rows) - with from_date and procedure_status='IN_PROGRESS'
INSERT INTO medical_procedure (procedure_id, appointment_id, h_id, provider_id, doctor_id, from_date, to_date, diagnosis, recommendations, procedure_type, procedure_status) VALUES
('PROC046', 'APP001', 'HID001', 'PROV001', 'DOC001', '2023-10-01 09:00:00', '2023-12-31 17:00:00', 'Chronic hypertension management', 'Monthly follow-ups needed', 'LONG_TERM', 'IN_PROGRESS'),
('PROC047', 'APP002', 'HID002', 'PROV001', 'DOC001', '2023-09-15 10:00:00', '2024-03-15 17:00:00', 'Hyperlipidemia treatment', 'Quarterly lipid panels required', 'LONG_TERM', 'IN_PROGRESS'),
('PROC048', 'APP003', 'HID003', 'PROV001', 'DOC001', '2023-10-10 08:00:00', '2024-10-10 17:00:00', 'Type 2 diabetes management', 'Continuous glucose monitoring', 'LONG_TERM', 'IN_PROGRESS'),
('PROC049', 'APP004', 'HID004', 'PROV001', 'DOC001', '2023-09-01 11:00:00', '2024-09-01 17:00:00', 'Post-cardiac surgery rehab', 'Weekly physical therapy', 'LONG_TERM', 'IN_PROGRESS'),
('PROC050', 'APP005', 'HID005', 'PROV001', 'DOC001', '2023-08-01 14:00:00', '2024-02-01 17:00:00', 'Chronic arrhythmia treatment', 'Regular Holter monitoring', 'LONG_TERM', 'IN_PROGRESS'),
('PROC051', 'APP006', 'HID006', 'PROV001', 'DOC001', '2023-10-05 10:00:00', '2024-04-05 17:00:00', 'Severe asthma management', 'Biologic therapy regimen', 'LONG_TERM', 'IN_PROGRESS'),
('PROC052', 'APP007', 'HID007', 'PROV001', 'DOC001', '2023-07-01 09:00:00', '2024-07-01 17:00:00', 'Congestive heart failure', 'Monthly cardiac assessments', 'LONG_TERM', 'IN_PROGRESS'),
('PROC053', 'APP008', 'HID008', 'PROV001', 'DOC001', '2023-09-20 13:00:00', '2024-03-20 17:00:00', 'Stable angina management', 'Gradual exercise program', 'LONG_TERM', 'IN_PROGRESS'),
('PROC054', 'APP009', 'HID009', 'PROV001', 'DOC001', '2023-10-01 08:00:00', '2024-01-01 17:00:00', 'Peripheral artery disease', 'Supervised walking program', 'LONG_TERM', 'IN_PROGRESS'),
('PROC055', 'APP010', 'HID010', 'PROV001', 'DOC001', '2023-08-15 11:00:00', '2024-08-15 17:00:00', 'Chronic atrial fibrillation', 'Anticoagulation therapy', 'LONG_TERM', 'IN_PROGRESS');

-- Long-term procedures SCHEDULED (15 rows) - with scheduled_date and procedure_status='SCHEDULED'
INSERT INTO medical_procedure (procedure_id, appointment_id, h_id, provider_id, doctor_id,from_date, diagnosis, recommendations, procedure_type, procedure_status) VALUES
('PROC056', 'APP001', 'HID001', 'PROV001', 'DOC001', '2023-11-15', 'Hypertension annual review', 'Prepare lab results for review', 'LONG_TERM', 'IN_PROGRESS'),
('PROC057', 'APP002', 'HID002', 'PROV001', 'DOC001', '2023-11-20', 'Cholesterol annual check', 'Fasting required before appointment', 'LONG_TERM', 'IN_PROGRESS'),
('PROC058', 'APP003', 'HID003', 'PROV001', 'DOC001', '2023-12-01', 'Diabetes comprehensive exam', 'Bring glucose logs', 'LONG_TERM', 'IN_PROGRESS'),
('PROC059', 'APP004', 'HID004', 'PROV001', 'DOC001', '2023-11-10', 'Cardiac rehab assessment', 'Wear exercise clothing', 'LONG_TERM', 'IN_PROGRESS'),
('PROC061', 'APP006', 'HID006', 'PROV001', 'DOC001', '2024-01-05', 'Asthma control evaluation', 'Complete symptom questionnaire', 'LONG_TERM', 'IN_PROGRESS'),
('PROC062', 'APP007', 'HID007', 'PROV001', 'DOC001', '2023-11-30', 'Heart failure monitoring', 'Weigh daily before appointment', 'LONG_TERM', 'IN_PROGRESS'),
('PROC063', 'APP008', 'HID008', 'PROV001', 'DOC001', '2024-02-15', 'Angina management review', 'Track nitroglycerin use', 'LONG_TERM', 'IN_PROGRESS'),
('PROC064', 'APP009', 'HID009', 'PROV001', 'DOC001', '2023-12-10', 'PAD vascular assessment', 'Wear comfortable shoes', 'LONG_TERM', 'IN_PROGRESS'),
('PROC065', 'APP010', 'HID010', 'PROV001', 'DOC001', '2024-03-01', 'AFib annual review', 'Prepare INR records', 'LONG_TERM', 'IN_PROGRESS'),
('PROC066', 'APP011', 'HID001', 'PROV001', 'DOC002', '2023-11-05', 'Pediatric vaccination schedule', 'Prepare for next round of shots', 'LONG_TERM', 'IN_PROGRESS'),
('PROC067', 'APP012', 'HID002', 'PROV001', 'DOC002', '2024-01-15', 'Annual pediatric wellness', 'Complete developmental forms', 'LONG_TERM', 'IN_PROGRESS'),
('PROC068', 'APP013', 'HID003', 'PROV001', 'DOC002', '2023-12-20', 'Chronic ear infection follow-up', 'Monitor for recurrence', 'LONG_TERM', 'IN_PROGRESS'),
('PROC069', 'APP014', 'HID004', 'PROV001', 'DOC002', '2024-02-01', 'Allergy immunotherapy review', 'Track symptom frequency', 'LONG_TERM', 'IN_PROGRESS'),
('PROC070', 'APP015', 'HID005', 'PROV001', 'DOC002', '2023-11-25', 'Infant milestone assessment', 'Bring growth records', 'LONG_TERM', 'IN_PROGRESS'),
('PROC071', 'APP015', 'HID005', 'PROV001', 'DOC002', '2023-11-25', 'Infant milestone assessment', 'Bring growth records', 'LONG_TERM', 'IN_PROGRESS'),
('PROC073', 'APP015', 'HID005', 'PROV001', 'DOC002', '2023-11-25', 'Infant milestone assessment', 'Bring growth records', 'LONG_TERM', 'IN_PROGRESS'),
('PROC074', 'APP010', 'HID010', 'PROV001', 'DOC001', '2024-03-01', 'AFib annual review', 'Prepare INR records', 'LONG_TERM', 'IN_PROGRESS'),
('PROC075', 'APP010', 'HID010', 'PROV001', 'DOC001', '2024-03-01', 'AFib annual review', 'Prepare INR records', 'LONG_TERM', 'IN_PROGRESS'),
('PROC076', 'APP010', 'HID010', 'PROV001', 'DOC001', '2024-03-01', 'AFib annual review', 'Prepare INR records', 'LONG_TERM', 'IN_PROGRESS');

-- PROC046
-- Example prescriptions for PROC046 (HID001, PROV001, DOC001)
INSERT INTO prescription VALUES
('PRESC001', 'PROC046', 'HID001', 'PROV001', 'DOC001', 'DOC001', '2023-10-01 10:00:00', '2023-10-01', '2023-10-31','dummy', CURRENT_TIMESTAMP),
('PRESC002', 'PROC046', 'HID001', 'PROV001', 'DOC001', 'DOC001', '2023-10-08 10:00:00', '2023-10-08', '2023-11-07','dummy', CURRENT_TIMESTAMP),
('PRESC003', 'PROC046', 'HID001', 'PROV001', 'DOC001', 'DOC001', '2023-10-15 10:00:00', '2023-10-15', '2023-11-14','dummy', CURRENT_TIMESTAMP),
('PRESC004', 'PROC046', 'HID001', 'PROV001', 'DOC001', 'DOC001', '2023-10-22 10:00:00', '2023-10-22', '2023-11-21','dummy', CURRENT_TIMESTAMP);

-- Repeat PRESC005–PRESC040 similarly for PROC047 to PROC055 with appropriate h_id and scheduling.

-- Correct format for prescription entries linked to PROC047
INSERT INTO prescription VALUES
('PRESC005', 'PROC047', 'HID002', 'PROV001', 'DOC002', 'DOC001', '2023-09-15 09:00:00', '2023-09-15', '2023-10-15','dummy', CURRENT_TIMESTAMP),
('PRESC006', 'PROC047', 'HID002', 'PROV001', 'DOC002', 'DOC001', '2023-09-22 09:00:00', '2023-09-22', '2023-10-22','dummy', CURRENT_TIMESTAMP),
('PRESC007', 'PROC047', 'HID002', 'PROV001', 'DOC002', 'DOC001', '2023-09-29 09:00:00', '2023-09-29', '2023-10-29','dummy', CURRENT_TIMESTAMP),
('PRESC008', 'PROC047', 'HID002', 'PROV001', 'DOC002', 'DOC001', '2023-10-06 09:00:00', '2023-10-06', '2023-11-06','dummy', CURRENT_TIMESTAMP);
-- Medicines for PRESC001 to PRESC004
INSERT INTO prescribed_medicines VALUES
('PMED001', 'PRESC001', 'Amlodipine', 'tablet', '5mg', '30 days', 'Take in morning', '2023-10-01', '2023-10-31', CURRENT_TIMESTAMP),
('PMED002', 'PRESC001', 'Losartan', 'tablet', '50mg', '30 days', 'After breakfast', '2023-10-01', '2023-10-31', CURRENT_TIMESTAMP),
('PMED003', 'PRESC001', 'Hydrochlorothiazide', 'tablet', '25mg', '30 days', 'Diuretic regimen', '2023-10-01', '2023-10-31', CURRENT_TIMESTAMP),
('PMED004', 'PRESC001', 'Metoprolol', 'tablet', '50mg', '30 days', 'Reduce heart rate', '2023-10-01', '2023-10-31', CURRENT_TIMESTAMP),
('PMED005', 'PRESC001', 'Clonidine', 'tablet', '0.1mg', '30 days', 'Watch for drowsiness', '2023-10-01', '2023-10-31', CURRENT_TIMESTAMP),
('PMED006', 'PRESC001', 'Telmisartan', 'tablet', '40mg', '30 days', 'Continue daily dosing', '2023-10-01', '2023-10-31', CURRENT_TIMESTAMP);
-- Repeat pattern for PRESC002–PRESC004 using PMED007–PMED030

-- Medicines for PRESC005 to PRESC008
INSERT INTO prescribed_medicines VALUES
('PMED031', 'PRESC005', 'Atorvastatin', 'tablet', '10mg', '90 days', 'Take once nightly', '2023-09-15', '2023-12-13', CURRENT_TIMESTAMP),
('PMED032', 'PRESC005', 'Rosuvastatin', 'tablet', '20mg', '90 days', 'LDL focus, check after 3 weeks', '2023-09-15', '2023-12-13', CURRENT_TIMESTAMP),
('PMED033', 'PRESC005', 'Fenofibrate', 'tablet', '160mg', '60 days', 'Take with evening meal', '2023-09-15', '2023-11-13', CURRENT_TIMESTAMP),
('PMED034', 'PRESC005', 'Ezetimibe', 'tablet', '10mg', '60 days', 'Cholesterol absorption blocker', '2023-09-15', '2023-11-13', CURRENT_TIMESTAMP),
('PMED035', 'PRESC005', 'Omega-3 Fatty Acids', 'syrup', '1g', '90 days', 'Twice daily—after meals', '2023-09-15', '2023-12-13', CURRENT_TIMESTAMP),
('PMED036', 'PRESC005', 'Niacin', 'tablet', '500mg', '30 days', 'Monitor flushing side effects', '2023-09-15', '2023-10-14', CURRENT_TIMESTAMP);
-- Continue pattern for PMED037–PMED060 for PRESC006–PRESC008
-- Tests for PRESC001
INSERT INTO prescribed_tests VALUES
('PTEST001', 'PRESC001', 'Blood Pressure Monitoring', '2023-10-02', 'AM and PM readings', CURRENT_TIMESTAMP),
('PTEST002', 'PRESC001', 'Renal Panel', '2023-10-03', 'Check creatinine', CURRENT_TIMESTAMP),
('PTEST003', 'PRESC001', 'Electrolytes', '2023-10-04', 'Sodium and potassium', CURRENT_TIMESTAMP),
('PTEST004', 'PRESC001', 'ECG', '2023-10-05', 'Baseline check', CURRENT_TIMESTAMP),
('PTEST005', 'PRESC001', 'Cardiac Echo', '2023-10-06', 'Assess LV function', CURRENT_TIMESTAMP),
('PTEST006', 'PRESC001', '24-Hour BP Monitor', '2023-10-07', 'Ambulatory setup', CURRENT_TIMESTAMP);
-- Repeat for PTEST007–PTEST030 for PRESC002–PRESC004

-- Tests for PRESC005
INSERT INTO prescribed_tests VALUES
('PTEST031', 'PRESC005', 'Lipid Profile', '2023-09-16', 'Fasting required', CURRENT_TIMESTAMP),
('PTEST032', 'PRESC005', 'Liver Function Test', '2023-09-17', 'Check ALT/AST', CURRENT_TIMESTAMP),
('PTEST033', 'PRESC005', 'CK Level', '2023-09-18', 'Muscle enzyme baseline', CURRENT_TIMESTAMP),
('PTEST034', 'PRESC005', 'Thyroid Panel', '2023-09-19', 'Evaluate TSH', CURRENT_TIMESTAMP),
('PTEST035', 'PRESC005', 'Vitamin D', '2023-09-20', 'Deficiency screen', CURRENT_TIMESTAMP),
('PTEST036', 'PRESC005', 'Repeat Lipids', '2023-09-21', 'Verify response', CURRENT_TIMESTAMP);
-- Logs for PROC046
-- PROC046 logs
INSERT INTO procedure_daily_log VALUES
('PLOG001', 'PROC046', 'DOC001', '2023-10-01 09:00:00', NULL, 'Initial visit completed', CURRENT_TIMESTAMP),
('PLOG002', 'PROC046', 'DOC001', '2023-10-02 10:30:00', NULL, 'Prescription PRESC001 issued', CURRENT_TIMESTAMP),
('PLOG003', 'PROC046', 'DOC001', '2023-10-04 13:00:00', 'BP: 140/90', 'BP readings uploaded', CURRENT_TIMESTAMP),
('PLOG004', 'PROC046', 'DOC001', '2023-10-06 15:00:00', NULL, 'Lab results reviewed', CURRENT_TIMESTAMP),
('PLOG005', 'PROC046', 'DOC001', '2023-10-08 17:00:00', NULL, 'Dosage adjusted', CURRENT_TIMESTAMP);

-- PROC047 logs
INSERT INTO procedure_daily_log VALUES
('PLOG006', 'PROC047', 'DOC001', '2023-09-15 10:00:00', NULL, 'Lipid therapy started', CURRENT_TIMESTAMP),
('PLOG007', 'PROC047', 'DOC001', '2023-09-16 11:15:00', NULL, 'Prescription PRESC005 issued', CURRENT_TIMESTAMP),
('PLOG008', 'PROC047', 'DOC001', '2023-09-18 09:00:00', 'ALT/AST normal', 'Liver tests normal', CURRENT_TIMESTAMP),
('PLOG009', 'PROC047', 'DOC001', '2023-09-20 14:30:00', NULL, 'Muscle soreness reported', CURRENT_TIMESTAMP),
('PLOG010', 'PROC047', 'DOC001', '2023-09-22 16:00:00', NULL, 'Switched to Rosuvastatin', CURRENT_TIMESTAMP);
-- Continue through PTEST037–PTEST060 for PRESC006–PRESC008
-- Insert claims
INSERT INTO Claims (claim_id, subscribe_id, procedure_id, provider_id, h_id, claim_status, claim_date, amount_claimed, amount_approved)
VALUES
('CLAIM001', 'SUB001', 'PROC001', 'PROV001', 'HID001', 'APPROVED', '2023-10-16', 5000, 4500),
('CLAIM002', 'SUB002', 'PROC001', 'PROV001', 'HID001', 'APPROVED', '2023-10-16', 5000, 5000),
('CLAIM003', 'SUB021', 'PROC011', 'PROV001', 'HID001', 'APPROVED', '2023-10-16', 3000, 3000),
('CLAIM004', 'SUB022', 'PROC011', 'PROV001', 'HID001', 'DENIED', '2023-10-16', 3000, 0),
('CLAIM005', 'SUB004', 'PROC002', 'PROV001', 'HID002', 'APPROVED', '2023-10-16', 4500, 4000),
('CLAIM006', 'SUB005', 'PROC002', 'PROV001', 'HID002', 'APPROVED', '2023-10-16', 4500, 4500),
('CLAIM007', 'SUB025', 'PROC012', 'PROV001', 'HID002', 'APPROVED', '2023-10-16', 2000, 2000),
('CLAIM008', 'SUB007', 'PROC003', 'PROV001', 'HID003', 'PENDING', '2023-10-16', 6000, 0),
('CLAIM009', 'SUB008', 'PROC003', 'PROV001', 'HID003', 'APPROVED', '2023-10-16', 6000, 5500),
('CLAIM010', 'SUB029', 'PROC013', 'PROV001', 'HID003', 'APPROVED', '2023-10-16', 2500, 2500),
('CLAIM011', 'SUB010', 'PROC004', 'PROV001', 'HID004', 'APPROVED', '2023-10-16', 8000, 7500),
('CLAIM012', 'SUB011', 'PROC004', 'PROV001', 'HID004', 'APPROVED', '2023-10-16', 8000, 8000),
('CLAIM013', 'SUB032', 'PROC014', 'PROV001', 'HID004', 'DENIED', '2023-10-16', 3500, 0),
('CLAIM014', 'SUB013', 'PROC005', 'PROV001', 'HID005', 'APPROVED', '2023-10-16', 5500, 5000),
('CLAIM015', 'SUB014', 'PROC005', 'PROV001', 'HID005', 'APPROVED', '2023-10-16', 5500, 5500),
('CLAIM016', 'SUB035', 'PROC015', 'PROV001', 'HID005', 'APPROVED', '2023-10-16', 1800, 1800),
('CLAIM017', 'SUB016', 'PROC006', 'PROV001', 'HID006', 'APPROVED', '2023-10-16', 4000, 4000),
('CLAIM018', 'SUB017', 'PROC006', 'PROV001', 'HID006', 'DENIED', '2023-10-16', 4000, 0),
('CLAIM019', 'SUB038', 'PROC016', 'PROV001', 'HID006', 'APPROVED', '2023-10-16', 3000, 3000),
('CLAIM020', 'SUB019', 'PROC007', 'PROV001', 'HID007', 'APPROVED', '2023-10-16', 7000, 6500);

-- Insert claim history
INSERT INTO Claim_history (claim_history_id, claim_id, description, action_date)
VALUES
('CHIST001', 'CLAIM001', 'Claim submitted', '2023-10-16 09:00:00'),
('CHIST002', 'CLAIM001', 'Initial review completed', '2023-10-17 10:00:00'),
('CHIST003', 'CLAIM001', 'Approved with partial payment', '2023-10-18 11:00:00'),
('CHIST004', 'CLAIM002', 'Claim submitted', '2023-10-16 09:05:00'),
('CHIST005', 'CLAIM002', 'Approved for full amount', '2023-10-17 10:30:00'),
('CHIST006', 'CLAIM003', 'Claim submitted', '2023-10-16 09:10:00'),
('CHIST007', 'CLAIM003', 'Approved for full amount', '2023-10-17 09:30:00'),
('CHIST008', 'CLAIM004', 'Claim submitted', '2023-10-16 09:15:00'),
('CHIST009', 'CLAIM004', 'Denied - procedure not covered', '2023-10-18 14:00:00'),
('CHIST010', 'CLAIM005', 'Claim submitted', '2023-10-16 09:20:00'),
('CHIST011', 'CLAIM005', 'Approved with partial payment', '2023-10-18 10:00:00'),
('CHIST012', 'CLAIM006', 'Claim submitted', '2023-10-16 09:25:00'),
('CHIST013', 'CLAIM006', 'Approved for full amount', '2023-10-17 11:00:00'),
('CHIST014', 'CLAIM007', 'Claim submitted', '2023-10-16 09:30:00'),
('CHIST015', 'CLAIM007', 'Approved for full amount', '2023-10-17 11:30:00'),
('CHIST016', 'CLAIM008', 'Claim submitted', '2023-10-16 09:35:00'),
('CHIST017', 'CLAIM009', 'Claim submitted', '2023-10-16 09:40:00'),
('CHIST018', 'CLAIM009', 'Approved with partial payment', '2023-10-18 15:00:00'),
('CHIST019', 'CLAIM010', 'Claim submitted', '2023-10-16 09:45:00'),
('CHIST020', 'CLAIM010', 'Approved for full amount', '2023-10-17 16:00:00');
-- Insert payment history
INSERT INTO Payment_history (h_id, provider_id, amount, payment_method, payment_status, payment_date, remarks)
VALUES
('HID001', 'PROV001', 500, 'CREDIT_CARD', 'completed', '2023-10-15 10:45:00', 'Co-payment for procedure'),
('HID002', 'PROV001', 500, 'DEBIT_CARD', 'completed', '2023-10-15 11:15:00', 'Co-payment for procedure'),
('HID003', 'PROV001', 500, 'CREDIT_CARD', 'completed', '2023-10-15 11:45:00', 'Co-payment for procedure'),
('HID004', 'PROV001', 1000, 'DEBIT_CARD', 'completed', '2023-10-15 12:15:00', 'Co-payment for procedure'),
('HID005', 'PROV001', 500, 'CREDIT_CARD', 'completed', '2023-10-15 12:45:00', 'Co-payment for procedure'),
('HID006', 'PROV001', 500, 'DEBIT_CARD', 'completed', '2023-10-15 13:15:00', 'Co-payment for procedure'),
('HID007', 'PROV001', 1000, 'CREDIT_CARD', 'completed', '2023-10-15 13:45:00', 'Co-payment for procedure'),
('HID008', 'PROV001', 500, 'DEBIT_CARD', 'completed', '2023-10-16 10:45:00', 'Co-payment for procedure'),
('HID009', 'PROV001', 500, 'CREDIT_CARD', 'completed', '2023-10-16 11:15:00', 'Co-payment for procedure'),
('HID010', 'PROV001', 500, 'DEBIT_CARD', 'completed', '2023-10-16 11:45:00', 'Co-payment for procedure'),
('HID001', 'PROV001', 300, 'CREDIT_CARD', 'completed', '2023-10-15 10:45:00', 'Co-payment for pediatric visit'),
('HID002', 'PROV001', 300, 'DEBIT_CARD', 'completed', '2023-10-15 11:15:00', 'Co-payment for pediatric visit'),
('HID003', 'PROV001', 300, 'CREDIT_CARD', 'completed', '2023-10-15 11:45:00', 'Co-payment for pediatric visit'),
('HID004', 'PROV001', 300, 'DEBIT_CARD', 'completed', '2023-10-15 12:15:00', 'Co-payment for pediatric visit'),
('HID005', 'PROV001', 300, 'CREDIT_CARD', 'completed', '2023-10-15 12:45:00', 'Co-payment for pediatric visit'),
('HID006', 'PROV001', 300, 'DEBIT_CARD', 'completed', '2023-10-15 13:15:00', 'Co-payment for pediatric visit'),
('HID007', 'PROV001', 300, 'CREDIT_CARD', 'completed', '2023-10-15 13:45:00', 'Co-payment for pediatric visit'),
('HID008', 'PROV001', 300, 'DEBIT_CARD', 'completed', '2023-10-16 10:45:00', 'Co-payment for pediatric visit'),
('HID009', 'PROV001', 300, 'CREDIT_CARD', 'completed', '2023-10-16 11:15:00', 'Co-payment for pediatric visit'),
('HID010', 'PROV001', 300, 'DEBIT_CARD', 'completed', '2023-10-16 11:45:00', 'Co-payment for pediatric visit');