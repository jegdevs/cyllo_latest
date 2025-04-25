// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pipelineModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNewpipeCollection on Isar {
  IsarCollection<Newpipe> get newpipes => this.collection();
}

const NewpipeSchema = CollectionSchema(
  name: r'Newpipe',
  id: 482766159904447417,
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
    r'imageData': PropertySchema(
      id: 13,
      name: r'imageData',
      type: IsarType.string,
    ),
    r'leadId': PropertySchema(
      id: 14,
      name: r'leadId',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 15,
      name: r'name',
      type: IsarType.string,
    ),
    r'partnerId': PropertySchema(
      id: 16,
      name: r'partnerId',
      type: IsarType.longList,
    ),
    r'partnerName': PropertySchema(
      id: 17,
      name: r'partnerName',
      type: IsarType.string,
    ),
    r'phone': PropertySchema(
      id: 18,
      name: r'phone',
      type: IsarType.string,
    ),
    r'priority': PropertySchema(
      id: 19,
      name: r'priority',
      type: IsarType.string,
    ),
    r'probability': PropertySchema(
      id: 20,
      name: r'probability',
      type: IsarType.double,
    ),
    r'proratedRevenue': PropertySchema(
      id: 21,
      name: r'proratedRevenue',
      type: IsarType.double,
    ),
    r'recurringRevenue': PropertySchema(
      id: 22,
      name: r'recurringRevenue',
      type: IsarType.double,
    ),
    r'recurringRevenueMonthly': PropertySchema(
      id: 23,
      name: r'recurringRevenueMonthly',
      type: IsarType.double,
    ),
    r'recurringRevenueMonthlyProrated': PropertySchema(
      id: 24,
      name: r'recurringRevenueMonthlyProrated',
      type: IsarType.double,
    ),
    r'recurringRevenueProrated': PropertySchema(
      id: 25,
      name: r'recurringRevenueProrated',
      type: IsarType.double,
    ),
    r'stageId': PropertySchema(
      id: 26,
      name: r'stageId',
      type: IsarType.longList,
    ),
    r'stageName': PropertySchema(
      id: 27,
      name: r'stageName',
      type: IsarType.string,
    ),
    r'tagIds': PropertySchema(
      id: 28,
      name: r'tagIds',
      type: IsarType.longList,
    ),
    r'teamId': PropertySchema(
      id: 29,
      name: r'teamId',
      type: IsarType.longList,
    ),
    r'type': PropertySchema(
      id: 30,
      name: r'type',
      type: IsarType.string,
    ),
    r'userId': PropertySchema(
      id: 31,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _newpipeEstimateSize,
  serialize: _newpipeSerialize,
  deserialize: _newpipeDeserialize,
  deserializeProp: _newpipeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _newpipeGetId,
  getLinks: _newpipeGetLinks,
  attach: _newpipeAttach,
  version: '3.1.0+1',
);

int _newpipeEstimateSize(
  Newpipe object,
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
    final value = object.imageData;
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

void _newpipeSerialize(
  Newpipe object,
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
  writer.writeString(offsets[13], object.imageData);
  writer.writeLong(offsets[14], object.leadId);
  writer.writeString(offsets[15], object.name);
  writer.writeLongList(offsets[16], object.partnerId);
  writer.writeString(offsets[17], object.partnerName);
  writer.writeString(offsets[18], object.phone);
  writer.writeString(offsets[19], object.priority);
  writer.writeDouble(offsets[20], object.probability);
  writer.writeDouble(offsets[21], object.proratedRevenue);
  writer.writeDouble(offsets[22], object.recurringRevenue);
  writer.writeDouble(offsets[23], object.recurringRevenueMonthly);
  writer.writeDouble(offsets[24], object.recurringRevenueMonthlyProrated);
  writer.writeDouble(offsets[25], object.recurringRevenueProrated);
  writer.writeLongList(offsets[26], object.stageId);
  writer.writeString(offsets[27], object.stageName);
  writer.writeLongList(offsets[28], object.tagIds);
  writer.writeLongList(offsets[29], object.teamId);
  writer.writeString(offsets[30], object.type);
  writer.writeLong(offsets[31], object.userId);
}

Newpipe _newpipeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Newpipe();
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
  object.imageData = reader.readStringOrNull(offsets[13]);
  object.leadId = reader.readLongOrNull(offsets[14]);
  object.name = reader.readStringOrNull(offsets[15]);
  object.partnerId = reader.readLongList(offsets[16]);
  object.partnerName = reader.readStringOrNull(offsets[17]);
  object.phone = reader.readStringOrNull(offsets[18]);
  object.priority = reader.readStringOrNull(offsets[19]);
  object.probability = reader.readDoubleOrNull(offsets[20]);
  object.proratedRevenue = reader.readDoubleOrNull(offsets[21]);
  object.recurringRevenue = reader.readDoubleOrNull(offsets[22]);
  object.recurringRevenueMonthly = reader.readDoubleOrNull(offsets[23]);
  object.recurringRevenueMonthlyProrated = reader.readDoubleOrNull(offsets[24]);
  object.recurringRevenueProrated = reader.readDoubleOrNull(offsets[25]);
  object.stageId = reader.readLongList(offsets[26]);
  object.stageName = reader.readStringOrNull(offsets[27]);
  object.tagIds = reader.readLongList(offsets[28]);
  object.teamId = reader.readLongList(offsets[29]);
  object.type = reader.readStringOrNull(offsets[30]);
  object.userId = reader.readLongOrNull(offsets[31]);
  return object;
}

P _newpipeDeserializeProp<P>(
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
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    case 16:
      return (reader.readLongList(offset)) as P;
    case 17:
      return (reader.readStringOrNull(offset)) as P;
    case 18:
      return (reader.readStringOrNull(offset)) as P;
    case 19:
      return (reader.readStringOrNull(offset)) as P;
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
      return (reader.readDoubleOrNull(offset)) as P;
    case 26:
      return (reader.readLongList(offset)) as P;
    case 27:
      return (reader.readStringOrNull(offset)) as P;
    case 28:
      return (reader.readLongList(offset)) as P;
    case 29:
      return (reader.readLongList(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset)) as P;
    case 31:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _newpipeGetId(Newpipe object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _newpipeGetLinks(Newpipe object) {
  return [];
}

void _newpipeAttach(IsarCollection<dynamic> col, Id id, Newpipe object) {
  object.id = id;
}

extension NewpipeQueryWhereSort on QueryBuilder<Newpipe, Newpipe, QWhere> {
  QueryBuilder<Newpipe, Newpipe, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NewpipeQueryWhere on QueryBuilder<Newpipe, Newpipe, QWhereClause> {
  QueryBuilder<Newpipe, Newpipe, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Newpipe, Newpipe, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterWhereClause> idBetween(
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

extension NewpipeQueryFilter
    on QueryBuilder<Newpipe, Newpipe, QFilterCondition> {
  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityDateDeadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityDateDeadline',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityDateDeadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityDateDeadline',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityDateDeadlineContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityDateDeadlineMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityDateDeadline',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityDateDeadlineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityDateDeadline',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityDateDeadlineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityDateDeadline',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityIds',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityIds',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityIdsElementBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityIdsLengthEqualTo(int length) {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityIdsIsEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityIdsIsNotEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityIdsLengthLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityIdsLengthBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityState',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityStateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityState',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityStateGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityStateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityState',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityStateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityState',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityTypeIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityTypeId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityTypeIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityTypeId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityTypeIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityTypeNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityTypeNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityTypeName',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityTypeNameEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityTypeNameBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityTypeNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityTypeName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityTypeNameMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityTypeNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityTypeNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityTypeName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> activityUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityUserId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityUserId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityUserIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      activityUserIdIsEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contactName',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contactName',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> contactNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      contactNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createDate',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createDate',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> createDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateClosed',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateClosed',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateClosed',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dateClosedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateClosed',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayCloseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayClose',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayCloseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayClose',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayCloseEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayCloseGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayCloseLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayCloseBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayOpenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayOpen',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayOpenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayOpen',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayOpenEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayOpenGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayOpenLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> dayOpenBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailFrom',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailFrom',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> emailFromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emailFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      expectedRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedRevenue',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      expectedRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedRevenue',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> expectedRevenueEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> expectedRevenueLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> expectedRevenueBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageData',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageData',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageData',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageData',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageData',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> imageDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageData',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> leadIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leadId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> leadIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leadId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> leadIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leadId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> leadIdGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> leadIdLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> leadIdBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdElementBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdLengthEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdIsEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdIsNotEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdLengthLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerIdLengthBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerName',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerName',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> partnerNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      partnerNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'partnerName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'phone',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> phoneIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'phone',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> priorityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> probabilityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'probability',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> probabilityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'probability',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> probabilityEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> probabilityGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> probabilityLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> probabilityBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      proratedRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'proratedRevenue',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      proratedRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'proratedRevenue',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> proratedRevenueEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> proratedRevenueLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> proratedRevenueBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenue',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenue',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> recurringRevenueEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> recurringRevenueBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueMonthlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueMonthly',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueMonthlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueMonthly',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueMonthlyProratedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueMonthlyProrated',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueMonthlyProratedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueMonthlyProrated',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueProratedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueProrated',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      recurringRevenueProratedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueProrated',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stageId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stageId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      stageIdElementGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdElementLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdElementBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdLengthEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdIsEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdIsNotEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdLengthLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      stageIdLengthGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageIdLengthBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stageName',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stageName',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameContains(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> stageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stageName',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagIds',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagIds',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      tagIdsElementGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsElementLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsElementBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsLengthEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsIsEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsIsNotEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsLengthLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsLengthGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> tagIdsLengthBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teamId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teamId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition>
      teamIdElementGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdElementLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdElementBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdLengthEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdIsEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdIsNotEmpty() {
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdLengthLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdLengthGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> teamIdLengthBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'type',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeEqualTo(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeBetween(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeStartsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeEndsWith(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeMatches(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> userIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> userIdGreaterThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> userIdLessThan(
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

  QueryBuilder<Newpipe, Newpipe, QAfterFilterCondition> userIdBetween(
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

extension NewpipeQueryObject
    on QueryBuilder<Newpipe, Newpipe, QFilterCondition> {}

extension NewpipeQueryLinks
    on QueryBuilder<Newpipe, Newpipe, QFilterCondition> {}

extension NewpipeQuerySortBy on QueryBuilder<Newpipe, Newpipe, QSortBy> {
  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByActivityDateDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      sortByActivityDateDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByActivityState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityState', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByActivityStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityState', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByCreateDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByCreateDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByDateClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByDateClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByDayCloseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByDayOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByEmailFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByEmailFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByExpectedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByImageData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageData', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByImageDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageData', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByLeadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByPartnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByPartnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByProbabilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByProratedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByRecurringRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      sortByRecurringRevenueMonthlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      sortByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      sortByRecurringRevenueMonthlyProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      sortByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      sortByRecurringRevenueProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByStageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageName', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByStageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageName', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension NewpipeQuerySortThenBy
    on QueryBuilder<Newpipe, Newpipe, QSortThenBy> {
  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByActivityDateDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      thenByActivityDateDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByActivityState() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityState', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByActivityStateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityState', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByActivityTypeName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByActivityTypeNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityTypeName', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByCreateDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByCreateDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByDateClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByDateClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByDayCloseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByDayOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByEmailFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByEmailFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByExpectedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByImageData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageData', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByImageDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageData', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByLeadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByPartnerName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByPartnerNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'partnerName', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByPhone() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByPhoneDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'phone', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByProbabilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByProratedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByRecurringRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      thenByRecurringRevenueMonthlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      thenByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      thenByRecurringRevenueMonthlyProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      thenByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy>
      thenByRecurringRevenueProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByStageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageName', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByStageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stageName', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension NewpipeQueryWhereDistinct
    on QueryBuilder<Newpipe, Newpipe, QDistinct> {
  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByActivityDateDeadline(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityDateDeadline',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByActivityIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityIds');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByActivityState(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityState',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByActivityTypeId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeId');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByActivityTypeName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityTypeName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByActivityUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityUserId');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByContactName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByCreateDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByDateClosed(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateClosed', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayClose');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOpen');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByEmailFrom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emailFrom', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedRevenue');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByImageData(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageData', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leadId');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByPartnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerId');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByPartnerName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByPhone(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'phone', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByPriority(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'probability');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proratedRevenue');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenue');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct>
      distinctByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueMonthly');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct>
      distinctByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueMonthlyProrated');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct>
      distinctByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueProrated');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByStageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stageId');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByStageName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stageName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByTagIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagIds');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamId');
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Newpipe, Newpipe, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension NewpipeQueryProperty
    on QueryBuilder<Newpipe, Newpipe, QQueryProperty> {
  QueryBuilder<Newpipe, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations>
      activityDateDeadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityDateDeadline');
    });
  }

  QueryBuilder<Newpipe, List<int>?, QQueryOperations> activityIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityIds');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> activityStateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityState');
    });
  }

  QueryBuilder<Newpipe, List<int>?, QQueryOperations> activityTypeIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeId');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> activityTypeNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityTypeName');
    });
  }

  QueryBuilder<Newpipe, List<int>?, QQueryOperations> activityUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityUserId');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> contactNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactName');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> createDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createDate');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> dateClosedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateClosed');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations> dayCloseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayClose');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations> dayOpenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOpen');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> emailFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emailFrom');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations> expectedRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedRevenue');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> imageDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageData');
    });
  }

  QueryBuilder<Newpipe, int?, QQueryOperations> leadIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leadId');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Newpipe, List<int>?, QQueryOperations> partnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerId');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> partnerNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerName');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> phoneProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'phone');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations> probabilityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'probability');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations> proratedRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proratedRevenue');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations> recurringRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenue');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations>
      recurringRevenueMonthlyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueMonthly');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations>
      recurringRevenueMonthlyProratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueMonthlyProrated');
    });
  }

  QueryBuilder<Newpipe, double?, QQueryOperations>
      recurringRevenueProratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueProrated');
    });
  }

  QueryBuilder<Newpipe, List<int>?, QQueryOperations> stageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stageId');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> stageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stageName');
    });
  }

  QueryBuilder<Newpipe, List<int>?, QQueryOperations> tagIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagIds');
    });
  }

  QueryBuilder<Newpipe, List<int>?, QQueryOperations> teamIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamId');
    });
  }

  QueryBuilder<Newpipe, String?, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<Newpipe, int?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserImageCollection on Isar {
  IsarCollection<UserImage> get userImages => this.collection();
}

const UserImageSchema = CollectionSchema(
  name: r'UserImage',
  id: -5358790493356921512,
  properties: {
    r'imageData': PropertySchema(
      id: 0,
      name: r'imageData',
      type: IsarType.byteList,
    ),
    r'userId': PropertySchema(
      id: 1,
      name: r'userId',
      type: IsarType.long,
    )
  },
  estimateSize: _userImageEstimateSize,
  serialize: _userImageSerialize,
  deserialize: _userImageDeserialize,
  deserializeProp: _userImageDeserializeProp,
  idName: r'id',
  indexes: {
    r'userId': IndexSchema(
      id: -2005826577402374815,
      name: r'userId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'userId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _userImageGetId,
  getLinks: _userImageGetLinks,
  attach: _userImageAttach,
  version: '3.1.0+1',
);

int _userImageEstimateSize(
  UserImage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.imageData;
    if (value != null) {
      bytesCount += 3 + value.length;
    }
  }
  return bytesCount;
}

void _userImageSerialize(
  UserImage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeByteList(offsets[0], object.imageData);
  writer.writeLong(offsets[1], object.userId);
}

UserImage _userImageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserImage();
  object.id = id;
  object.imageData = reader.readByteList(offsets[0]);
  object.userId = reader.readLongOrNull(offsets[1]);
  return object;
}

P _userImageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readByteList(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userImageGetId(UserImage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userImageGetLinks(UserImage object) {
  return [];
}

void _userImageAttach(IsarCollection<dynamic> col, Id id, UserImage object) {
  object.id = id;
}

extension UserImageByIndex on IsarCollection<UserImage> {
  Future<UserImage?> getByUserId(int? userId) {
    return getByIndex(r'userId', [userId]);
  }

  UserImage? getByUserIdSync(int? userId) {
    return getByIndexSync(r'userId', [userId]);
  }

  Future<bool> deleteByUserId(int? userId) {
    return deleteByIndex(r'userId', [userId]);
  }

  bool deleteByUserIdSync(int? userId) {
    return deleteByIndexSync(r'userId', [userId]);
  }

  Future<List<UserImage?>> getAllByUserId(List<int?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'userId', values);
  }

  List<UserImage?> getAllByUserIdSync(List<int?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'userId', values);
  }

  Future<int> deleteAllByUserId(List<int?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'userId', values);
  }

  int deleteAllByUserIdSync(List<int?> userIdValues) {
    final values = userIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'userId', values);
  }

  Future<Id> putByUserId(UserImage object) {
    return putByIndex(r'userId', object);
  }

  Id putByUserIdSync(UserImage object, {bool saveLinks = true}) {
    return putByIndexSync(r'userId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUserId(List<UserImage> objects) {
    return putAllByIndex(r'userId', objects);
  }

  List<Id> putAllByUserIdSync(List<UserImage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'userId', objects, saveLinks: saveLinks);
  }
}

extension UserImageQueryWhereSort
    on QueryBuilder<UserImage, UserImage, QWhere> {
  QueryBuilder<UserImage, UserImage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhere> anyUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'userId'),
      );
    });
  }
}

extension UserImageQueryWhere
    on QueryBuilder<UserImage, UserImage, QWhereClause> {
  QueryBuilder<UserImage, UserImage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> idBetween(
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

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> userIdEqualTo(
      int? userId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'userId',
        value: [userId],
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> userIdNotEqualTo(
      int? userId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [userId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'userId',
              lower: [],
              upper: [userId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> userIdGreaterThan(
    int? userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [userId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> userIdLessThan(
    int? userId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [],
        upper: [userId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterWhereClause> userIdBetween(
    int? lowerUserId,
    int? upperUserId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'userId',
        lower: [lowerUserId],
        includeLower: includeLower,
        upper: [upperUserId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserImageQueryFilter
    on QueryBuilder<UserImage, UserImage, QFilterCondition> {
  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> imageDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageData',
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageData',
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageData',
        value: value,
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageData',
        value: value,
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageData',
        value: value,
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageData',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageData',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> imageDataIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageData',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageData',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageData',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageData',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition>
      imageDataLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'imageData',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> userIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> userIdGreaterThan(
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

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> userIdLessThan(
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

  QueryBuilder<UserImage, UserImage, QAfterFilterCondition> userIdBetween(
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

extension UserImageQueryObject
    on QueryBuilder<UserImage, UserImage, QFilterCondition> {}

extension UserImageQueryLinks
    on QueryBuilder<UserImage, UserImage, QFilterCondition> {}

extension UserImageQuerySortBy on QueryBuilder<UserImage, UserImage, QSortBy> {
  QueryBuilder<UserImage, UserImage, QAfterSortBy> sortByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterSortBy> sortByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserImageQuerySortThenBy
    on QueryBuilder<UserImage, UserImage, QSortThenBy> {
  QueryBuilder<UserImage, UserImage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterSortBy> thenByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.asc);
    });
  }

  QueryBuilder<UserImage, UserImage, QAfterSortBy> thenByUserIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userId', Sort.desc);
    });
  }
}

extension UserImageQueryWhereDistinct
    on QueryBuilder<UserImage, UserImage, QDistinct> {
  QueryBuilder<UserImage, UserImage, QDistinct> distinctByImageData() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageData');
    });
  }

  QueryBuilder<UserImage, UserImage, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension UserImageQueryProperty
    on QueryBuilder<UserImage, UserImage, QQueryProperty> {
  QueryBuilder<UserImage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserImage, List<int>?, QQueryOperations> imageDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageData');
    });
  }

  QueryBuilder<UserImage, int?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTagCollection on Isar {
  IsarCollection<Tag> get tags => this.collection();
}

const TagSchema = CollectionSchema(
  name: r'Tag',
  id: 4007045862261149568,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'tagId': PropertySchema(
      id: 1,
      name: r'tagId',
      type: IsarType.long,
    )
  },
  estimateSize: _tagEstimateSize,
  serialize: _tagSerialize,
  deserialize: _tagDeserialize,
  deserializeProp: _tagDeserializeProp,
  idName: r'id',
  indexes: {
    r'tagId': IndexSchema(
      id: -2598179288284149414,
      name: r'tagId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tagId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _tagGetId,
  getLinks: _tagGetLinks,
  attach: _tagAttach,
  version: '3.1.0+1',
);

int _tagEstimateSize(
  Tag object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _tagSerialize(
  Tag object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeLong(offsets[1], object.tagId);
}

Tag _tagDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Tag();
  object.id = id;
  object.name = reader.readStringOrNull(offsets[0]);
  object.tagId = reader.readLongOrNull(offsets[1]);
  return object;
}

P _tagDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _tagGetId(Tag object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _tagGetLinks(Tag object) {
  return [];
}

void _tagAttach(IsarCollection<dynamic> col, Id id, Tag object) {
  object.id = id;
}

extension TagByIndex on IsarCollection<Tag> {
  Future<Tag?> getByTagId(int? tagId) {
    return getByIndex(r'tagId', [tagId]);
  }

  Tag? getByTagIdSync(int? tagId) {
    return getByIndexSync(r'tagId', [tagId]);
  }

  Future<bool> deleteByTagId(int? tagId) {
    return deleteByIndex(r'tagId', [tagId]);
  }

  bool deleteByTagIdSync(int? tagId) {
    return deleteByIndexSync(r'tagId', [tagId]);
  }

  Future<List<Tag?>> getAllByTagId(List<int?> tagIdValues) {
    final values = tagIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'tagId', values);
  }

  List<Tag?> getAllByTagIdSync(List<int?> tagIdValues) {
    final values = tagIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'tagId', values);
  }

  Future<int> deleteAllByTagId(List<int?> tagIdValues) {
    final values = tagIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'tagId', values);
  }

  int deleteAllByTagIdSync(List<int?> tagIdValues) {
    final values = tagIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'tagId', values);
  }

  Future<Id> putByTagId(Tag object) {
    return putByIndex(r'tagId', object);
  }

  Id putByTagIdSync(Tag object, {bool saveLinks = true}) {
    return putByIndexSync(r'tagId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByTagId(List<Tag> objects) {
    return putAllByIndex(r'tagId', objects);
  }

  List<Id> putAllByTagIdSync(List<Tag> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'tagId', objects, saveLinks: saveLinks);
  }
}

extension TagQueryWhereSort on QueryBuilder<Tag, Tag, QWhere> {
  QueryBuilder<Tag, Tag, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhere> anyTagId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tagId'),
      );
    });
  }
}

extension TagQueryWhere on QueryBuilder<Tag, Tag, QWhereClause> {
  QueryBuilder<Tag, Tag, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Tag, Tag, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> idBetween(
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

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tagId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tagId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagIdEqualTo(int? tagId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tagId',
        value: [tagId],
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagIdNotEqualTo(int? tagId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tagId',
              lower: [],
              upper: [tagId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tagId',
              lower: [tagId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tagId',
              lower: [tagId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tagId',
              lower: [],
              upper: [tagId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagIdGreaterThan(
    int? tagId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tagId',
        lower: [tagId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagIdLessThan(
    int? tagId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tagId',
        lower: [],
        upper: [tagId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterWhereClause> tagIdBetween(
    int? lowerTagId,
    int? upperTagId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tagId',
        lower: [lowerTagId],
        includeLower: includeLower,
        upper: [upperTagId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TagQueryFilter on QueryBuilder<Tag, Tag, QFilterCondition> {
  QueryBuilder<Tag, Tag, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagId',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagId',
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagId',
        value: value,
      ));
    });
  }

  QueryBuilder<Tag, Tag, QAfterFilterCondition> tagIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TagQueryObject on QueryBuilder<Tag, Tag, QFilterCondition> {}

extension TagQueryLinks on QueryBuilder<Tag, Tag, QFilterCondition> {}

extension TagQuerySortBy on QueryBuilder<Tag, Tag, QSortBy> {
  QueryBuilder<Tag, Tag, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByTagId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagId', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> sortByTagIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagId', Sort.desc);
    });
  }
}

extension TagQuerySortThenBy on QueryBuilder<Tag, Tag, QSortThenBy> {
  QueryBuilder<Tag, Tag, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByTagId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagId', Sort.asc);
    });
  }

  QueryBuilder<Tag, Tag, QAfterSortBy> thenByTagIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagId', Sort.desc);
    });
  }
}

extension TagQueryWhereDistinct on QueryBuilder<Tag, Tag, QDistinct> {
  QueryBuilder<Tag, Tag, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Tag, Tag, QDistinct> distinctByTagId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagId');
    });
  }
}

extension TagQueryProperty on QueryBuilder<Tag, Tag, QQueryProperty> {
  QueryBuilder<Tag, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Tag, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Tag, int?, QQueryOperations> tagIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagId');
    });
  }
}
