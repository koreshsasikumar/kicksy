class Address {
  final String houseNo;
  final String city;
  final String state;
  final String pinCode;
  final String fullAddress;
  final bool isLoading;

  Address({
    this.houseNo = '',
    this.city = '',
    this.state = '',
    this.pinCode = '',
    this.fullAddress = '',
    this.isLoading = false,
  });

  Address copyWith({
    String? houseNo,
    String? city,
    String? state,
    String? pinCode,
    String? fullAddress,
    bool? isLoading,
  }) {
    return Address(
      houseNo: houseNo ?? this.houseNo,
      city: city ?? this.city,
      state: state ?? this.state,
      pinCode: pinCode ?? this.pinCode,
      fullAddress: fullAddress ?? this.fullAddress,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
