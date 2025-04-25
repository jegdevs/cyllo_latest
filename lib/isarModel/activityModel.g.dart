// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activityModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNewactCollection on Isar {
  IsarCollection<Newact> get newacts => this.collection();
}

const NewactSchema = CollectionSchema(
  name: r'Newact',
  id: 9052657397387568897,
  properties: {
    r'activityDateDeadline': PropertySchema(
      id: 0,
      name: r'activityDateDeadline',
      type: IsarType.string,
    ),
    r'activityIds': PropertySchema(
      id: 1,
      name: r'activityIds',
      type: IsarType.longList,
    ),
    r'activityState': PropertySchema(
      id: 2,
      name: r'activityState',
      type: IsarType.string,
    ),
    r'activityTypeId': PropertySchema(
      id: 3,
      name: r'activityTypeId',
      type: IsarType.longList,
    ),
    r'activityTypeName': PropertySchema(
      id: 4,
      name: r'activityTypeName',
      type: IsarType.string,
    ),
    r'activityUserId': PropertySchema(
      id: 5,
      name: r'activityUserId',
      type: IsarType.longList,
    ),
    r'contactName': PropertySchema(
      id: 6,
      name: r'contactName',
      type: IsarType.string,
    ),
    r'createDate': PropertySchema(
      id: 7,
      name: r'createDate',
      type: IsarType.string,
    ),
    r'dateClosed': PropertySchema(
      id: 8,
      name: r'dateClosed',
      type: IsarType.string,
    ),
    r'dayClose': PropertySchema(
      id: 9,
      name: r'dayClose',
      type: IsarType.double,
    ),
    r'dayOpen': PropertySchema(
      id: 10,
      name: r'dayOpen',
      type: IsarType.double,
    ),
    r'emailFrom': PropertySchema(
      id: 11,
      name: r'emailFrom',
      type: IsarType.string,
    ),
    r'expectedRevenue': PropertySchema(
      id: 12,
      name: r'expectedRevenue',
      type: IsarType.double,
    ),
    r'leadId': PropertySchema(
      id: 13,
      name: r'leadId',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 14,
      name: r'name',
      type: IsarType.string,
    ),
    r'partnerId': PropertySchema(
      id: 15,
      name: r'partnerId',
      type: IsarType.longList,
    ),
    r'partnerName': PropertySchema(
      id: 16,
      name: r'partnerName',
      type: IsarType.string,
    ),
    r'phone': PropertySchema(
      id: 17,
      name: r'phone',
      type: IsarType.string,
    ),
    r'priority': PropertySchema(
      id: 18,
      name: r'priority',
      type: IsarType.string,
    ),
    r'probability': PropertySchema(
      id: 19,
      name: r'probability',
      type: IsarType.double,
    ),
    r'proratedRevenue': PropertySchema(
      id: 20,
      name: r'proratedRevenue',
      type: IsarType.double,
    ),
    r'recurringRevenue': PropertySchema(
      id: 21,
      name: r'recurringRevenue',
      type: IsarType.double,
    ),
    r'recurringRevenueMonthly': PropertySchema(
      id: 22,
      name: r'recurringRevenueMonthly',
      type: IsarType.double,
    ),
    r'recurringRevenueMonthlyProrated': PropertySchema(
      id: 23,
      name: r'recurringRevenueMonthlyProrated',
      type: IsarType.double,
    ),
    r'recurringRevenueProrated': PropertySchema(
      id: 24,
      name: r'recurringRevenueProrated',
      type: IsarType.double,
    ),
    r'stageId': PropertySchema(
      id: 25,
      name: r'stageId',
      type: IsarType.longList,
    ),
    r'stageName': PropertySchema(
      id: 26,
      name: r'stageName',
      type: IsarType.string,
    ),
    r'tagIds': PropertySchema(
      id: 27,
      name: r'tagIds',
      type: IsarType.longList,
    ),
    r'teamId': PropertySchema(
      id: 28,
      name: r'teamId',
      type: IsarType.longList,
    ),
    r'type': PropertySchema(
      id: 29,
      name: r'type',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 30,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _newactEstimateSize,
  serialize: _newactSerialize,
  deserialize: _newactDeserialize,
  deserializeProp: _newactDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _newactGetId,
  getLinks: _newactGetLinks,
  attach: _newactAttach,
  version: '3.1.0+1',
);

int _newactEstimateSize(
  Newact object,
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
    final value = object.activityIds;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.activityState;
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
    final value = object.activityUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.contactName;
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
    final value = object.dateClosed;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.emailFrom;
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
    final value = object.phone;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.priority;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.stageId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.stageName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tagIds;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.teamId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.type;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _newactSerialize(
  Newact object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityDateDeadline);
  writer.writeLongList(offsets[1], object.activityIds);
  writer.writeString(offsets[2], object.activityState);
  writer.writeLongList(offsets[3], object.activityTypeId);
  writer.writeString(offsets[4], object.activityTypeName);
  writer.writeLongList(offsets[5], object.activityUserId);
  writer.writeString(offsets[6], object.contactName);
  writer.writeString(offsets[7], object.createDate);
  writer.writeString(offsets[8], object.dateClosed);
  writer.writeDouble(offsets[9], object.dayClose);
  writer.writeDouble(offsets[10], object.dayOpen);
  writer.writeString(offsets[11], object.emailFrom);
  writer.writeDouble(offsets[12], object.expectedRevenue);
  writer.writeLong(offsets[13], object.leadId);
  writer.writeString(offsets[14], object.name);
  writer.writeLongList(offsets[15], object.partnerId);
  writer.writeString(offsets[16], object.partnerName);
  writer.writeString(offsets[17], object.phone);
  writer.writeString(offsets[18], object.priority);
  writer.writeDouble(offsets[19], object.probability);
  writer.writeDouble(offsets[20], object.proratedRevenue);
  writer.writeDouble(offsets[21], object.recurringRevenue);
  writer.writeDouble(offsets[22], object.recurringRevenueMonthly);
  writer.writeDouble(offsets[23], object.recurringRevenueMonthlyProrated);
  writer.writeDouble(offsets[24], object.recurringRevenueProrated);
  writer.writeLongList(offsets[25], object.stageId);
  writer.writeString(offsets[26], object.stageName);
  writer.writeLongList(offsets[27], object.tagIds);
  writer.writeLongList(offsets[28], object.teamId);
  writer.writeString(offsets[29], object.type);
  writer.writeLong(offsets[30], object.userId);
}

Newact _newactDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Newact();
  object.activityDateDeadline = reader.readStringOrNull(offsets[0]);
  object.activityIds = reader.readLongList(offsets[1]);
  object.activityState = reader.readStringOrNull(offsets[2]);
  object.activityTypeId = reader.readLongList(offsets[3]);
  object.activityTypeName = reader.readStringOrNull(offsets[4]);
  object.activityUserId = reader.readLongList(offsets[5]);
  object.contactName = reader.readStringOrNull(offsets[6]);
  object.createDate = reader.readStringOrNull(offsets[7]);
  object.dateClosed = reader.readStringOrNull(offsets[8]);
  object.dayClose = reader.readDoubleOrNull(offsets[9]);
  object.dayOpen = reader.readDoubleOrNull(offsets[10]);
  object.emailFrom = reader.readStringOrNull(offsets[11]);
  object.expectedRevenue = reader.readDoubleOrNull(offsets[12]);
  object.id = id;
  object.leadId = reader.readLongOrNull(offsets[13]);
  object.name = reader.readStringOrNull(offsets[14]);
  object.partnerId = reader.readLongList(offsets[15]);
  object.partnerName = reader.readStringOrNull(offsets[16]);
  object.phone = reader.readStringOrNull(offsets[17]);
  object.priority = reader.readStringOrNull(offsets[18]);
  object.probability = reader.readDoubleOrNull(offsets[19]);
  object.proratedRevenue = reader.readDoubleOrNull(offsets[20]);
  object.recurringRevenue = reader.readDoubleOrNull(offsets[21]);
  object.recurringRevenueMonthly = reader.readDoubleOrNull(offsets[22]);
  object.recurringRevenueMonthlyProrated = reader.readDoubleOrNull(offsets[23]);
  object.recurringRevenueProrated = reader.readDoubleOrNull(offsets[24]);
  object.stageId = reader.readLongList(offsets[25]);
  object.stageName = reader.readStringOrNull(offsets[26]);
  object.tagIds = reader.readLongList(offsets[27]);
  object.teamId = reader.readLongList(offsets[28]);
  object.type = reader.readStringOrNull(offsets[29]);
  object.userId = reader.readLongOrNull(offsets[30]);
  return object;
}

P _newactDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongList(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLongList(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongList(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (reader.readDoubleOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset)) as P;
    case 15:
      return (reader.readLongList(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readDoubleOrNull(offset)) as P;
    case 20:
      return (reader.readDoubleOrNull(offset)) as P;
    case 21:
      return (reader.readDoubleOrNull(offset)) as P;
    case 22:
      return (reader.readDoubleOrNull(offset)) as P;
    case 23:
      return (reader.readDoubleOrNull(offset)) as P;
    case 24:
      return (reader.readDoubleOrNull(offset)) as P;
    case 25:
      return (reader.readLongList(offset)) as P;
    case 26:
      return (reader.readStringOrNull(offset)) as P;
    case 27:
      return (reader.readLongList(offset)) as P;
    case 28:
      return (reader.readLongList(offset)) as P;
    case 29:
      return (reader.readStringOrNull(offset)) as P;
    case 30:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _newactGetId(Newact object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _newactGetLinks(Newact object) {
  return [];
}

void _newactAttach(IsarCollection<dynamic> col, Id id, Newact object) {
  object.id = id;
}

extension NewactQueryWhereSort on QueryBuilder<Newact, Newact, QWhere> {
  QueryBuilder<Newact, Newact, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NewactQueryWhere on QueryBuilder<Newact, Newact, QWhereClause> {
  QueryBuilder<Newact, Newact, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Newact, Newact, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterWhereClause> idBetween(
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

extension NewactQueryFilter on QueryBuilder<Newact, Newact, QFilterCondition> {
  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityDateDeadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityDateDeadline',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityDateDeadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityDateDeadline',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityDateDeadlineContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityDateDeadlineMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityDateDeadline',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityDateDeadlineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityDateDeadline',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityDateDeadlineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityDateDeadline',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityIds',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityIds',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityState',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityState',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityState',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activityState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activityState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityState',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityState',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityStateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityState',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityStateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityState',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityTypeId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityTypeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityTypeId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityTypeIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeIdIsEmpty() {
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityTypeNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeNameEqualTo(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeNameLessThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeNameBetween(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeNameEndsWith(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityTypeNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityTypeName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityTypeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityTypeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityUserId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityUserId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activityUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activityUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activityUserId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityUserId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> activityUserIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityUserId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityUserId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityUserId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityUserId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      activityUserIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'activityUserId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contactName',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contactName',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contactName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contactName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contactName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> contactNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createDate',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createDate',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateEqualTo(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateGreaterThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateLessThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateBetween(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateStartsWith(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateEndsWith(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateContains(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateMatches(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> createDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateClosed',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateClosed',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateClosed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateClosed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateClosed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateClosed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateClosed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateClosed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateClosed',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateClosed',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateClosed',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dateClosedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateClosed',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayCloseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayClose',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayCloseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayClose',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayCloseEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayClose',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayCloseGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayClose',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayCloseLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayClose',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayCloseBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayClose',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayOpenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayOpen',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayOpenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayOpen',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayOpenEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dayOpen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayOpenGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dayOpen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayOpenLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dayOpen',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> dayOpenBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dayOpen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailFrom',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailFrom',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'emailFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'emailFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'emailFrom',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'emailFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'emailFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'emailFrom',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'emailFrom',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> emailFromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emailFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> expectedRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedRevenue',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      expectedRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedRevenue',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> expectedRevenueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      expectedRevenueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> expectedRevenueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> expectedRevenueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedRevenue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> leadIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leadId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> leadIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leadId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> leadIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leadId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> leadIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'leadId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> leadIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'leadId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> leadIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'leadId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdElementLessThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdElementBetween(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdLengthEqualTo(
      int length) {
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdIsEmpty() {
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdIsNotEmpty() {
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdLengthLessThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerIdLengthBetween(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerName',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerName',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameEqualTo(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameGreaterThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameLessThan(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameBetween(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameStartsWith(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameEndsWith(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameContains(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameMatches(
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> partnerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'partnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'phone',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'phone',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'phone',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'priority',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'priority',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'priority',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> priorityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> probabilityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'probability',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> probabilityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'probability',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> probabilityEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'probability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> probabilityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'probability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> probabilityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'probability',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> probabilityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'probability',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> proratedRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'proratedRevenue',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      proratedRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'proratedRevenue',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> proratedRevenueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'proratedRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      proratedRevenueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'proratedRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> proratedRevenueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'proratedRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> proratedRevenueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'proratedRevenue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> recurringRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenue',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenue',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> recurringRevenueEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurringRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> recurringRevenueLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurringRevenue',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> recurringRevenueBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurringRevenue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueMonthly',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueMonthly',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringRevenueMonthly',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurringRevenueMonthly',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurringRevenueMonthly',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurringRevenueMonthly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyProratedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueMonthlyProrated',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyProratedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueMonthlyProrated',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyProratedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringRevenueMonthlyProrated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyProratedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurringRevenueMonthlyProrated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyProratedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurringRevenueMonthlyProrated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueMonthlyProratedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurringRevenueMonthlyProrated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueProratedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueProrated',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueProratedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueProrated',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueProratedEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recurringRevenueProrated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueProratedGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recurringRevenueProrated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueProratedLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recurringRevenueProrated',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition>
      recurringRevenueProratedBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recurringRevenueProrated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stageId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stageId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stageId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stageId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stageId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stageId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stageId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stageId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stageId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'stageId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stageName',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stageName',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> stageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stageName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagIds',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagIds',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagIds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagIds',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagIds',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagIds',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagIds',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagIds',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> tagIdsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagIds',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teamId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teamId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'teamId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'teamId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'teamId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> teamIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'teamId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> userIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newact, Newact, QAfterFilterCondition> userIdGreaterThan(
    int? value, {
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> userIdLessThan(
    int? value, {
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

  QueryBuilder<Newact, Newact, QAfterFilterCondition> userIdBetween(
    int? lower,
    int? upper, {
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
}

extension NewactQueryObject on QueryBuilder<Newact, Newact, QFilterCondition> {}

extension NewactQueryLinks on QueryBuilder<Newact, Newact, QFilterCondition> {}

extension NewactQuerySortBy on QueryBuilder<Newact, Newact, QSortBy> {
  QueryBuilder<Newact, Newact, QAfterSortBy> sortByActivityDateDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByActivityDateDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByActivityState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityState', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByActivityStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityState', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByCreateDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByCreateDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByDateClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByDateClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByDayCloseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByDayOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByEmailFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByEmailFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByExpectedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByLeadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByPartnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByPartnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByProbabilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByProratedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByRecurringRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy>
      sortByRecurringRevenueMonthlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy>
      sortByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy>
      sortByRecurringRevenueMonthlyProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy>
      sortByRecurringRevenueProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByStageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageName', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByStageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageName', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension NewactQuerySortThenBy on QueryBuilder<Newact, Newact, QSortThenBy> {
  QueryBuilder<Newact, Newact, QAfterSortBy> thenByActivityDateDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByActivityDateDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByActivityState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityState', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByActivityStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityState', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByCreateDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByCreateDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByDateClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByDateClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByDayCloseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByDayOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByEmailFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByEmailFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByExpectedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByLeadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByPartnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByPartnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByProbabilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByProratedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByRecurringRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy>
      thenByRecurringRevenueMonthlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy>
      thenByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy>
      thenByRecurringRevenueMonthlyProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy>
      thenByRecurringRevenueProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByStageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageName', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByStageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageName', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Newact, Newact, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension NewactQueryWhereDistinct on QueryBuilder<Newact, Newact, QDistinct> {
  QueryBuilder<Newact, Newact, QDistinct> distinctByActivityDateDeadline(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityDateDeadline',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByActivityIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityIds');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByActivityState(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityState',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByActivityTypeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeId');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByActivityTypeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByActivityUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityUserId');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByContactName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByCreateDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByDateClosed(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateClosed', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayClose');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOpen');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByEmailFrom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emailFrom', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedRevenue');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leadId');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByPartnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerId');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByPartnerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByPriority(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'probability');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proratedRevenue');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenue');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueMonthly');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct>
      distinctByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueMonthlyProrated');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueProrated');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByStageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stageId');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByStageName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stageName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByTagIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagIds');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamId');
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newact, Newact, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension NewactQueryProperty on QueryBuilder<Newact, Newact, QQueryProperty> {
  QueryBuilder<Newact, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations>
      activityDateDeadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityDateDeadline');
    });
  }

  QueryBuilder<Newact, List<int>?, QQueryOperations> activityIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityIds');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> activityStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityState');
    });
  }

  QueryBuilder<Newact, List<int>?, QQueryOperations> activityTypeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeId');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> activityTypeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeName');
    });
  }

  QueryBuilder<Newact, List<int>?, QQueryOperations> activityUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityUserId');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> contactNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactName');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> createDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createDate');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> dateClosedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateClosed');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations> dayCloseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayClose');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations> dayOpenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOpen');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> emailFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emailFrom');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations> expectedRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedRevenue');
    });
  }

  QueryBuilder<Newact, int?, QQueryOperations> leadIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leadId');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Newact, List<int>?, QQueryOperations> partnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerId');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> partnerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerName');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations> probabilityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'probability');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations> proratedRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proratedRevenue');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations> recurringRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenue');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations>
      recurringRevenueMonthlyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueMonthly');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations>
      recurringRevenueMonthlyProratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueMonthlyProrated');
    });
  }

  QueryBuilder<Newact, double?, QQueryOperations>
      recurringRevenueProratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueProrated');
    });
  }

  QueryBuilder<Newact, List<int>?, QQueryOperations> stageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stageId');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> stageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stageName');
    });
  }

  QueryBuilder<Newact, List<int>?, QQueryOperations> tagIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagIds');
    });
  }

  QueryBuilder<Newact, List<int>?, QQueryOperations> teamIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamId');
    });
  }

  QueryBuilder<Newact, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Newact, int?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
