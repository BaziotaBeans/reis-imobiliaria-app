enum BoxDetailItemExtraEnum {
  bathroom,
  room,
  suites,
  vacancy,
}

enum PaymentMethodEnum {
  reference_payment,
  transfer_payment,
}

enum ProfileOptionsEnum {
  edit,
  change_password,
  policies_and_privacy,
  contract,
  exit,
  oder
}

enum UserTypeEnum { client, company }

enum PaymentModalityEnum {
  quarterly,
  semiannual,
  yearly,
}

enum PropertyStatus {
  PUBLISHED, // Disponível para ser agendado para visitas
  STANDBY, // Aguardando ser publicado ou disponibilizado para visitas
  RENTED // Já foi arrendado, não está disponível para novas visitas
}
