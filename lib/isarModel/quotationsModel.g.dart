// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotationsModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSaleOrderCollection on Isar {
  IsarCollection<SaleOrder> get saleOrders => this.collection();
}

const SaleOrderSchema = CollectionSchema(
  name: r'SaleOrder',
  id: 834483691778827062,
  properties: {
    r'activityDateDeadline': PropertySchema(
      id: 0,
      name: r'activityDateDeadline',
      type: IsarType.string,
    ),
    r'activitySummary': PropertySchema(
      id: 1,
      name: r'activitySummary',
      type: IsarType.string,
    ),
    r'activityTypeId': PropertySchema(
      id: 2,
      name: r'activityTypeId',
      type: IsarType.longList,
    ),
    r'activityTypeName': PropertySchema(
      id: 3,
      name: r'activityTypeName',
      type: IsarType.string,
    ),
    r'amountTax': PropertySchema(
      id: 4,
      name: r'amountTax',
      type: IsarType.double,
    ),
    r'amountToInvoice': PropertySchema(
      id: 5,
      name: r'amountToInvoice',
      type: IsarType.double,
    ),
    r'amountTotal': PropertySchema(
      id: 6,
      name: r'amountTotal',
      type: IsarType.double,
    ),
    r'amountUntaxed': PropertySchema(
      id: 7,
      name: r'amountUntaxed',
      type: IsarType.double,
    ),
    r'companyId': PropertySchema(
      id: 8,
      name: r'companyId',
      type: IsarType.longList,
    ),
    r'companyName': PropertySchema(
      id: 9,
      name: r'companyName',
      type: IsarType.string,
    ),
    r'createDate': PropertySchema(
      id: 10,
      name: r'createDate',
      type: IsarType.string,
    ),
    r'currencyRate': PropertySchema(
      id: 11,
      name: r'currencyRate',
      type: IsarType.double,
    ),
    r'dateOrder': PropertySchema(
      id: 12,
      name: r'dateOrder',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 13,
      name: r'name',
      type: IsarType.string,
    ),
    r'partnerId': PropertySchema(
      id: 14,
      name: r'partnerId',
      type: IsarType.longList,
    ),
    r'partnerName': PropertySchema(
      id: 15,
      name: r'partnerName',
      type: IsarType.string,
    ),
    r'prepaymentPercent': PropertySchema(
      id: 16,
      name: r'prepaymentPercent',
      type: IsarType.double,
    ),
    r'shippingWeight': PropertySchema(
      id: 17,
      name: r'shippingWeight',
      type: IsarType.double,
    ),
    r'state': PropertySchema(
      id: 18,
      name: r'state',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 19,
      name: r'userId',
      type: IsarType.longList,
    ),
    r'userName': PropertySchema(
      id: 20,
      name: r'userName',
      type: IsarType.string,
    )
  },
  estimateSize: _saleOrderEstimateSize,
  serialize: _saleOrderSerialize,
  deserialize: _saleOrderDeserialize,
  deserializeProp: _saleOrderDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _saleOrderGetId,
  getLinks: _saleOrderGetLinks,
  attach: _saleOrderAttach,
  version: '3.1.0+1',
);

int _saleOrderEstimateSize(
  SaleOrder object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.activityDateDeadline;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.activitySummary;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.activityTypeId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.activityTypeName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.companyId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.companyName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.createDate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dateOrder;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.partnerId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.partnerName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.state;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.userName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _saleOrderSerialize(
  SaleOrder object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityDateDeadline);
  writer.writeString(offsets[1], object.activitySummary);
  writer.writeLongList(offsets[2], object.activityTypeId);
  writer.writeString(offsets[3], object.activityTypeName);
  writer.writeDouble(offsets[4], object.amountTax);
  writer.writeDouble(offsets[5], object.amountToInvoice);
  writer.writeDouble(offsets[6], object.amountTotal);
  writer.writeDouble(offsets[7], object.amountUntaxed);
  writer.writeLongList(offsets[8], object.companyId);
  writer.writeString(offsets[9], object.companyName);
  writer.writeString(offsets[10], object.createDate);
  writer.writeDouble(offsets[11], object.currencyRate);
  writer.writeString(offsets[12], object.dateOrder);
  writer.writeString(offsets[13], object.name);
  writer.writeLongList(offsets[14], object.partnerId);
  writer.writeString(offsets[15], object.partnerName);
  writer.writeDouble(offsets[16], object.prepaymentPercent);
  writer.writeDouble(offsets[17], object.shippingWeight);
  writer.writeString(offsets[18], object.state);
  writer.writeLongList(offsets[19], object.userId);
  writer.writeString(offsets[20], object.userName);
}

SaleOrder _saleOrderDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SaleOrder();
  object.activityDateDeadline = reader.readStringOrNull(offsets[0]);
  object.activitySummary = reader.readStringOrNull(offsets[1]);
  object.activityTypeId = reader.readLongList(offsets[2]);
  object.activityTypeName = reader.readStringOrNull(offsets[3]);
  object.amountTax = reader.readDoubleOrNull(offsets[4]);
  object.amountToInvoice = reader.readDoubleOrNull(offsets[5]);
  object.amountTotal = reader.readDoubleOrNull(offsets[6]);
  object.amountUntaxed = reader.readDoubleOrNull(offsets[7]);
  object.companyId = reader.readLongList(offsets[8]);
  object.companyName = reader.readStringOrNull(offsets[9]);
  object.createDate = reader.readStringOrNull(offsets[10]);
  object.currencyRate = reader.readDoubleOrNull(offsets[11]);
  object.dateOrder = reader.readStringOrNull(offsets[12]);
  object.id = id;
  object.name = reader.readStringOrNull(offsets[13]);
  object.partnerId = reader.readLongList(offsets[14]);
  object.partnerName = reader.readStringOrNull(offsets[15]);
  object.prepaymentPercent = reader.readDoubleOrNull(offsets[16]);
  object.shippingWeight = reader.readDoubleOrNull(offsets[17]);
  object.state = reader.readStringOrNull(offsets[18]);
  object.userId = reader.readLongList(offsets[19]);
  object.userName = reader.readStringOrNull(offsets[20]);
  return object;
}

P _saleOrderDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLongList(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readDoubleOrNull(offset)) as P;
    case 6:
      return (reader.readDoubleOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongList(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongList(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readDoubleOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readLongList(offset)) as P;
    case 20:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _saleOrderGetId(SaleOrder object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _saleOrderGetLinks(SaleOrder object) {
  return [];
}

void _saleOrderAttach(IsarCollection<dynamic> col, Id id, SaleOrder object) {
  object.id = id;
}

extension SaleOrderQueryWhereSort
    on QueryBuilder<SaleOrder, SaleOrder, QWhere> {
  QueryBuilder<SaleOrder, SaleOrder, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SaleOrderQueryWhere
    on QueryBuilder<SaleOrder, SaleOrder, QWhereClause> {
  QueryBuilder<SaleOrder, SaleOrder, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SaleOrderQueryFilter
    on QueryBuilder<SaleOrder, SaleOrder, QFilterCondition> {
  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityDateDeadline',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityDateDeadline',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityDateDeadline',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityDateDeadline',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityDateDeadline',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityDateDeadlineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityDateDeadline',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activitySummary',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activitySummary',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activitySummary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activitySummary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activitySummary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activitySummary',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activitySummary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activitySummary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activitySummary',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activitySummary',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activitySummary',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activitySummaryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activitySummary',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityTypeId',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityTypeId',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityTypeId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityTypeId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityTypeId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityTypeId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityTypeId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityTypeId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityTypeId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityTypeId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityTypeId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityTypeName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityTypeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      activityTypeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> amountTaxIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amountTax',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountTaxIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amountTax',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> amountTaxEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountTax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountTaxGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountTax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> amountTaxLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountTax',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> amountTaxBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountTax',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountToInvoiceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amountToInvoice',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountToInvoiceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amountToInvoice',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountToInvoiceEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountToInvoice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountToInvoiceGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountToInvoice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountToInvoiceLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountToInvoice',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountToInvoiceBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountToInvoice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountTotalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amountTotal',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountTotalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amountTotal',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> amountTotalEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountTotalGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> amountTotalLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountTotal',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> amountTotalBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountUntaxedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amountUntaxed',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountUntaxedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amountUntaxed',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountUntaxedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amountUntaxed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountUntaxedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amountUntaxed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountUntaxedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amountUntaxed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      amountUntaxedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amountUntaxed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> companyIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companyId',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companyId',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companyId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> companyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companyId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companyId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companyId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companyId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'companyId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'companyName',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'companyName',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> companyNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> companyNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> companyNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> companyNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> companyNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> companyNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      companyNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> createDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createDate',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      createDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createDate',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> createDateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      createDateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> createDateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> createDateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      createDateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> createDateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> createDateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createDate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> createDateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createDate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      createDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createDate',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      createDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createDate',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      currencyRateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'currencyRate',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      currencyRateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'currencyRate',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> currencyRateEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currencyRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      currencyRateGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currencyRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      currencyRateLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currencyRate',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> currencyRateBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currencyRate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateOrder',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      dateOrderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateOrder',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOrder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      dateOrderGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateOrder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateOrder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateOrder',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateOrder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateOrder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateOrder',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateOrder',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> dateOrderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateOrder',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      dateOrderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateOrder',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> partnerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerId',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerId',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'partnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'partnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'partnerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> partnerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerName',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerName',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> partnerNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> partnerNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> partnerNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'partnerName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> partnerNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> partnerNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'partnerName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> partnerNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'partnerName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      partnerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'partnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      prepaymentPercentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'prepaymentPercent',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      prepaymentPercentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'prepaymentPercent',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      prepaymentPercentEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prepaymentPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      prepaymentPercentGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'prepaymentPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      prepaymentPercentLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'prepaymentPercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      prepaymentPercentBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'prepaymentPercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      shippingWeightIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shippingWeight',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      shippingWeightIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shippingWeight',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      shippingWeightEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shippingWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      shippingWeightGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shippingWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      shippingWeightLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shippingWeight',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      shippingWeightBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shippingWeight',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'state',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'state',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'state',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'state',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> stateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'state',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      userIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      userIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      userIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      userIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userIdLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      userIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      userIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'userId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userName',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      userNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userName',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition> userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterFilterCondition>
      userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }
}

extension SaleOrderQueryObject
    on QueryBuilder<SaleOrder, SaleOrder, QFilterCondition> {}

extension SaleOrderQueryLinks
    on QueryBuilder<SaleOrder, SaleOrder, QFilterCondition> {}

extension SaleOrderQuerySortBy on QueryBuilder<SaleOrder, SaleOrder, QSortBy> {
  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy>
      sortByActivityDateDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy>
      sortByActivityDateDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByActivitySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activitySummary', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByActivitySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activitySummary', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy>
      sortByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByAmountTax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTax', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByAmountTaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTax', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByAmountToInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountToInvoice', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByAmountToInvoiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountToInvoice', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByAmountTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTotal', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByAmountTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTotal', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByAmountUntaxed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountUntaxed', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByAmountUntaxedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountUntaxed', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByCreateDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByCreateDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByCurrencyRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyRate', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByCurrencyRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyRate', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByDateOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOrder', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByDateOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOrder', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByPartnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByPartnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByPrepaymentPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prepaymentPercent', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy>
      sortByPrepaymentPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prepaymentPercent', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByShippingWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shippingWeight', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByShippingWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shippingWeight', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension SaleOrderQuerySortThenBy
    on QueryBuilder<SaleOrder, SaleOrder, QSortThenBy> {
  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy>
      thenByActivityDateDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy>
      thenByActivityDateDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByActivitySummary() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activitySummary', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByActivitySummaryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activitySummary', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy>
      thenByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByAmountTax() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTax', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByAmountTaxDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTax', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByAmountToInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountToInvoice', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByAmountToInvoiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountToInvoice', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByAmountTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTotal', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByAmountTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountTotal', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByAmountUntaxed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountUntaxed', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByAmountUntaxedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amountUntaxed', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByCompanyName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByCompanyNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyName', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByCreateDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByCreateDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByCurrencyRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyRate', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByCurrencyRateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currencyRate', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByDateOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOrder', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByDateOrderDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateOrder', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByPartnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByPartnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByPrepaymentPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prepaymentPercent', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy>
      thenByPrepaymentPercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prepaymentPercent', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByShippingWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shippingWeight', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByShippingWeightDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shippingWeight', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'state', Sort.desc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QAfterSortBy> thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension SaleOrderQueryWhereDistinct
    on QueryBuilder<SaleOrder, SaleOrder, QDistinct> {
  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByActivityDateDeadline(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityDateDeadline',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByActivitySummary(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activitySummary',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByActivityTypeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeId');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByActivityTypeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByAmountTax() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountTax');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByAmountToInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountToInvoice');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByAmountTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountTotal');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByAmountUntaxed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amountUntaxed');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyId');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByCompanyName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByCreateDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByCurrencyRate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currencyRate');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByDateOrder(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateOrder', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByPartnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerId');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByPartnerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByPrepaymentPercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prepaymentPercent');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByShippingWeight() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shippingWeight');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByState(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'state', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }

  QueryBuilder<SaleOrder, SaleOrder, QDistinct> distinctByUserName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }
}

extension SaleOrderQueryProperty
    on QueryBuilder<SaleOrder, SaleOrder, QQueryProperty> {
  QueryBuilder<SaleOrder, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations>
      activityDateDeadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityDateDeadline');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations> activitySummaryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activitySummary');
    });
  }

  QueryBuilder<SaleOrder, List<int>?, QQueryOperations>
      activityTypeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeId');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations>
      activityTypeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeName');
    });
  }

  QueryBuilder<SaleOrder, double?, QQueryOperations> amountTaxProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountTax');
    });
  }

  QueryBuilder<SaleOrder, double?, QQueryOperations> amountToInvoiceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountToInvoice');
    });
  }

  QueryBuilder<SaleOrder, double?, QQueryOperations> amountTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountTotal');
    });
  }

  QueryBuilder<SaleOrder, double?, QQueryOperations> amountUntaxedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amountUntaxed');
    });
  }

  QueryBuilder<SaleOrder, List<int>?, QQueryOperations> companyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyId');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations> companyNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyName');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations> createDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createDate');
    });
  }

  QueryBuilder<SaleOrder, double?, QQueryOperations> currencyRateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currencyRate');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations> dateOrderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateOrder');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SaleOrder, List<int>?, QQueryOperations> partnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerId');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations> partnerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerName');
    });
  }

  QueryBuilder<SaleOrder, double?, QQueryOperations>
      prepaymentPercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prepaymentPercent');
    });
  }

  QueryBuilder<SaleOrder, double?, QQueryOperations> shippingWeightProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shippingWeight');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations> stateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'state');
    });
  }

  QueryBuilder<SaleOrder, List<int>?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }

  QueryBuilder<SaleOrder, String?, QQueryOperations> userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }
}
