// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leadModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLeadisarCollection on Isar {
  IsarCollection<Leadisar> get leadisars => this.collection();
}

const LeadisarSchema = CollectionSchema(
  name: r'Leadisar',
  id: 8729877084097971678,
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
    r'activityUserId': PropertySchema(
      id: 2,
      name: r'activityUserId',
      type: IsarType.longList,
    ),
    r'city': PropertySchema(
      id: 3,
      name: r'city',
      type: IsarType.string,
    ),
    r'contactName': PropertySchema(
      id: 4,
      name: r'contactName',
      type: IsarType.string,
    ),
    r'countryId': PropertySchema(
      id: 5,
      name: r'countryId',
      type: IsarType.longList,
    ),
    r'createDate': PropertySchema(
      id: 6,
      name: r'createDate',
      type: IsarType.string,
    ),
    r'dateClosed': PropertySchema(
      id: 7,
      name: r'dateClosed',
      type: IsarType.string,
    ),
    r'dayClose': PropertySchema(
      id: 8,
      name: r'dayClose',
      type: IsarType.double,
    ),
    r'dayOpen': PropertySchema(
      id: 9,
      name: r'dayOpen',
      type: IsarType.double,
    ),
    r'emailFrom': PropertySchema(
      id: 10,
      name: r'emailFrom',
      type: IsarType.string,
    ),
    r'expectedRevenue': PropertySchema(
      id: 11,
      name: r'expectedRevenue',
      type: IsarType.double,
    ),
    r'leadId': PropertySchema(
      id: 12,
      name: r'leadId',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 13,
      name: r'name',
      type: IsarType.string,
    ),
    r'partnerAssignedId': PropertySchema(
      id: 14,
      name: r'partnerAssignedId',
      type: IsarType.longList,
    ),
    r'partnerId': PropertySchema(
      id: 15,
      name: r'partnerId',
      type: IsarType.longList,
    ),
    r'priority': PropertySchema(
      id: 16,
      name: r'priority',
      type: IsarType.string,
    ),
    r'probability': PropertySchema(
      id: 17,
      name: r'probability',
      type: IsarType.double,
    ),
    r'proratedRevenue': PropertySchema(
      id: 18,
      name: r'proratedRevenue',
      type: IsarType.double,
    ),
    r'recurringRevenue': PropertySchema(
      id: 19,
      name: r'recurringRevenue',
      type: IsarType.double,
    ),
    r'recurringRevenueMonthly': PropertySchema(
      id: 20,
      name: r'recurringRevenueMonthly',
      type: IsarType.double,
    ),
    r'recurringRevenueMonthlyProrated': PropertySchema(
      id: 21,
      name: r'recurringRevenueMonthlyProrated',
      type: IsarType.double,
    ),
    r'recurringRevenueProrated': PropertySchema(
      id: 22,
      name: r'recurringRevenueProrated',
      type: IsarType.double,
    ),
    r'stageId': PropertySchema(
      id: 23,
      name: r'stageId',
      type: IsarType.longList,
    ),
    r'tagIds': PropertySchema(
      id: 24,
      name: r'tagIds',
      type: IsarType.longList,
    ),
    r'tagNames': PropertySchema(
      id: 25,
      name: r'tagNames',
      type: IsarType.string,
    ),
    r'teamId': PropertySchema(
      id: 26,
      name: r'teamId',
      type: IsarType.longList,
    ),
    r'userId': PropertySchema(
      id: 27,
      name: r'userId',
      type: IsarType.longList,
    )
  },
  estimateSize: _leadisarEstimateSize,
  serialize: _leadisarSerialize,
  deserialize: _leadisarDeserialize,
  deserializeProp: _leadisarDeserializeProp,
  idName: r'id',
  indexes: {
    r'leadId': IndexSchema(
      id: 2640900727793063999,
      name: r'leadId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'leadId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _leadisarGetId,
  getLinks: _leadisarGetLinks,
  attach: _leadisarAttach,
  version: '3.1.0+1',
);

int _leadisarEstimateSize(
  Leadisar object,
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
    final value = object.activityUserId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.city;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contactName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.countryId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
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
    final value = object.partnerAssignedId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.partnerId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
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
    final value = object.tagIds;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.tagNames;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.teamId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.userId;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  return bytesCount;
}

void _leadisarSerialize(
  Leadisar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.activityDateDeadline);
  writer.writeLongList(offsets[1], object.activityIds);
  writer.writeLongList(offsets[2], object.activityUserId);
  writer.writeString(offsets[3], object.city);
  writer.writeString(offsets[4], object.contactName);
  writer.writeLongList(offsets[5], object.countryId);
  writer.writeString(offsets[6], object.createDate);
  writer.writeString(offsets[7], object.dateClosed);
  writer.writeDouble(offsets[8], object.dayClose);
  writer.writeDouble(offsets[9], object.dayOpen);
  writer.writeString(offsets[10], object.emailFrom);
  writer.writeDouble(offsets[11], object.expectedRevenue);
  writer.writeLong(offsets[12], object.leadId);
  writer.writeString(offsets[13], object.name);
  writer.writeLongList(offsets[14], object.partnerAssignedId);
  writer.writeLongList(offsets[15], object.partnerId);
  writer.writeString(offsets[16], object.priority);
  writer.writeDouble(offsets[17], object.probability);
  writer.writeDouble(offsets[18], object.proratedRevenue);
  writer.writeDouble(offsets[19], object.recurringRevenue);
  writer.writeDouble(offsets[20], object.recurringRevenueMonthly);
  writer.writeDouble(offsets[21], object.recurringRevenueMonthlyProrated);
  writer.writeDouble(offsets[22], object.recurringRevenueProrated);
  writer.writeLongList(offsets[23], object.stageId);
  writer.writeLongList(offsets[24], object.tagIds);
  writer.writeString(offsets[25], object.tagNames);
  writer.writeLongList(offsets[26], object.teamId);
  writer.writeLongList(offsets[27], object.userId);
}

Leadisar _leadisarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Leadisar();
  object.activityDateDeadline = reader.readStringOrNull(offsets[0]);
  object.activityIds = reader.readLongList(offsets[1]);
  object.activityUserId = reader.readLongList(offsets[2]);
  object.city = reader.readStringOrNull(offsets[3]);
  object.contactName = reader.readStringOrNull(offsets[4]);
  object.countryId = reader.readLongList(offsets[5]);
  object.createDate = reader.readStringOrNull(offsets[6]);
  object.dateClosed = reader.readStringOrNull(offsets[7]);
  object.dayClose = reader.readDoubleOrNull(offsets[8]);
  object.dayOpen = reader.readDoubleOrNull(offsets[9]);
  object.emailFrom = reader.readStringOrNull(offsets[10]);
  object.expectedRevenue = reader.readDoubleOrNull(offsets[11]);
  object.id = id;
  object.leadId = reader.readLongOrNull(offsets[12]);
  object.name = reader.readStringOrNull(offsets[13]);
  object.partnerAssignedId = reader.readLongList(offsets[14]);
  object.partnerId = reader.readLongList(offsets[15]);
  object.priority = reader.readStringOrNull(offsets[16]);
  object.probability = reader.readDoubleOrNull(offsets[17]);
  object.proratedRevenue = reader.readDoubleOrNull(offsets[18]);
  object.recurringRevenue = reader.readDoubleOrNull(offsets[19]);
  object.recurringRevenueMonthly = reader.readDoubleOrNull(offsets[20]);
  object.recurringRevenueMonthlyProrated = reader.readDoubleOrNull(offsets[21]);
  object.recurringRevenueProrated = reader.readDoubleOrNull(offsets[22]);
  object.stageId = reader.readLongList(offsets[23]);
  object.tagIds = reader.readLongList(offsets[24]);
  object.tagNames = reader.readStringOrNull(offsets[25]);
  object.teamId = reader.readLongList(offsets[26]);
  object.userId = reader.readLongList(offsets[27]);
  return object;
}

P _leadisarDeserializeProp<P>(
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
      return (reader.readLongList(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readLongList(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDoubleOrNull(offset)) as P;
    case 9:
      return (reader.readDoubleOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLongList(offset)) as P;
    case 15:
      return (reader.readLongList(offset)) as P;
    case 16:
      return (reader.readStringOrNull(offset)) as P;
    case 17:
      return (reader.readDoubleOrNull(offset)) as P;
    case 18:
      return (reader.readDoubleOrNull(offset)) as P;
    case 19:
      return (reader.readDoubleOrNull(offset)) as P;
    case 20:
      return (reader.readDoubleOrNull(offset)) as P;
    case 21:
      return (reader.readDoubleOrNull(offset)) as P;
    case 22:
      return (reader.readDoubleOrNull(offset)) as P;
    case 23:
      return (reader.readLongList(offset)) as P;
    case 24:
      return (reader.readLongList(offset)) as P;
    case 25:
      return (reader.readStringOrNull(offset)) as P;
    case 26:
      return (reader.readLongList(offset)) as P;
    case 27:
      return (reader.readLongList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _leadisarGetId(Leadisar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _leadisarGetLinks(Leadisar object) {
  return [];
}

void _leadisarAttach(IsarCollection<dynamic> col, Id id, Leadisar object) {
  object.id = id;
}

extension LeadisarQueryWhereSort on QueryBuilder<Leadisar, Leadisar, QWhere> {
  QueryBuilder<Leadisar, Leadisar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhere> anyLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'leadId'),
      );
    });
  }
}

extension LeadisarQueryWhere on QueryBuilder<Leadisar, Leadisar, QWhereClause> {
  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> idBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> leadIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'leadId',
        value: [null],
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> leadIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'leadId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> leadIdEqualTo(
      int? leadId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'leadId',
        value: [leadId],
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> leadIdNotEqualTo(
      int? leadId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'leadId',
              lower: [],
              upper: [leadId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'leadId',
              lower: [leadId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'leadId',
              lower: [leadId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'leadId',
              lower: [],
              upper: [leadId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> leadIdGreaterThan(
    int? leadId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'leadId',
        lower: [leadId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> leadIdLessThan(
    int? leadId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'leadId',
        lower: [],
        upper: [leadId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterWhereClause> leadIdBetween(
    int? lowerLeadId,
    int? upperLeadId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'leadId',
        lower: [lowerLeadId],
        includeLower: includeLower,
        upper: [upperLeadId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LeadisarQueryFilter
    on QueryBuilder<Leadisar, Leadisar, QFilterCondition> {
  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityDateDeadlineIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityDateDeadline',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityDateDeadlineIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityDateDeadline',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityDateDeadlineContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activityDateDeadline',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityDateDeadlineMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activityDateDeadline',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityDateDeadlineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityDateDeadline',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityDateDeadlineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activityDateDeadline',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> activityIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityIds',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityIds',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityIdsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> activityIdsIsEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityUserIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'activityUserId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityUserIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'activityUserId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      activityUserIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activityUserId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'city',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'city',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'city',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'city',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> cityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'city',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contactName',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      contactNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contactName',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      contactNameGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameStartsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameEndsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameContains(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameMatches(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> contactNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      contactNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contactName',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> countryIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'countryId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> countryIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'countryId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'countryId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'countryId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'countryId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'countryId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'countryId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> countryIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'countryId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'countryId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'countryId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'countryId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      countryIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'countryId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createDate',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      createDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createDate',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateStartsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateEndsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateContains(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateMatches(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> createDateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      createDateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createDate',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateClosed',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      dateClosedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateClosed',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedStartsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedEndsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedContains(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedMatches(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dateClosedIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateClosed',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      dateClosedIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateClosed',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayCloseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayClose',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayCloseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayClose',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayCloseEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayCloseGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayCloseLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayCloseBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayOpenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dayOpen',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayOpenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dayOpen',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayOpenEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayOpenGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayOpenLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> dayOpenBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'emailFrom',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'emailFrom',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromStartsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromEndsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromContains(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromMatches(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> emailFromIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'emailFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      emailFromIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'emailFrom',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      expectedRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedRevenue',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      expectedRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedRevenue',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      expectedRevenueEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      expectedRevenueLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      expectedRevenueBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> leadIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'leadId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> leadIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'leadId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> leadIdEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'leadId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> leadIdGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> leadIdLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> leadIdBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameContains(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerAssignedId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerAssignedId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerAssignedId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'partnerAssignedId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'partnerAssignedId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'partnerAssignedId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerAssignedId',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerAssignedId',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerAssignedId',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerAssignedId',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerAssignedId',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerAssignedIdLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'partnerAssignedId',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> partnerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'partnerId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> partnerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'partnerId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      partnerIdElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'partnerId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> partnerIdIsEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'priority',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityStartsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityEndsWith(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityContains(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityMatches(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> priorityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'priority',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> probabilityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'probability',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      probabilityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'probability',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> probabilityEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      probabilityGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> probabilityLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> probabilityBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      proratedRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'proratedRevenue',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      proratedRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'proratedRevenue',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      proratedRevenueEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      proratedRevenueLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      proratedRevenueBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenue',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenue',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueMonthlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueMonthly',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueMonthlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueMonthly',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueMonthlyProratedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueMonthlyProrated',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueMonthlyProratedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueMonthlyProrated',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueProratedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'recurringRevenueProrated',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      recurringRevenueProratedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'recurringRevenueProrated',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stageId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stageId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stageId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      stageIdElementLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdElementBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdLengthEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdIsEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdIsNotEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdLengthLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> stageIdLengthBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagIds',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagIds',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagIds',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsElementLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsElementBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsLengthEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsIsEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsIsNotEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsLengthLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      tagIdsLengthGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagIdsLengthBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagNames',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagNames',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagNames',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagNames',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagNames',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagNames',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> tagNamesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagNames',
        value: '',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teamId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teamId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdElementLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdElementBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdLengthEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdIsEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdIsNotEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdLengthLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
      teamIdLengthGreaterThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> teamIdLengthBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'userId',
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdElementEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userId',
        value: value,
      ));
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdElementLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdElementBetween(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdLengthEqualTo(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdIsEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdIsNotEmpty() {
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdLengthLessThan(
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition>
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

  QueryBuilder<Leadisar, Leadisar, QAfterFilterCondition> userIdLengthBetween(
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
}

extension LeadisarQueryObject
    on QueryBuilder<Leadisar, Leadisar, QFilterCondition> {}

extension LeadisarQueryLinks
    on QueryBuilder<Leadisar, Leadisar, QFilterCondition> {}

extension LeadisarQuerySortBy on QueryBuilder<Leadisar, Leadisar, QSortBy> {
  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByActivityDateDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      sortByActivityDateDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByCreateDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByCreateDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByDateClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByDateClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByDayCloseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByDayOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByEmailFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByEmailFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByExpectedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByLeadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByProbabilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByProratedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByRecurringRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      sortByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      sortByRecurringRevenueMonthlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      sortByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      sortByRecurringRevenueMonthlyProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      sortByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      sortByRecurringRevenueProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByTagNames() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagNames', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> sortByTagNamesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagNames', Sort.desc);
    });
  }
}

extension LeadisarQuerySortThenBy
    on QueryBuilder<Leadisar, Leadisar, QSortThenBy> {
  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByActivityDateDeadline() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      thenByActivityDateDeadlineDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activityDateDeadline', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByCity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByCityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'city', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByContactName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByContactNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contactName', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByCreateDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByCreateDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createDate', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByDateClosed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByDateClosedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateClosed', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByDayCloseDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayClose', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByDayOpenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dayOpen', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByEmailFrom() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByEmailFromDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'emailFrom', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByExpectedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByLeadIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'leadId', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByPriority() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByPriorityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'priority', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByProbabilityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'probability', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByProratedRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'proratedRevenue', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByRecurringRevenueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenue', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      thenByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      thenByRecurringRevenueMonthlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthly', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      thenByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      thenByRecurringRevenueMonthlyProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueMonthlyProrated', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      thenByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy>
      thenByRecurringRevenueProratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recurringRevenueProrated', Sort.desc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByTagNames() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagNames', Sort.asc);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QAfterSortBy> thenByTagNamesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tagNames', Sort.desc);
    });
  }
}

extension LeadisarQueryWhereDistinct
    on QueryBuilder<Leadisar, Leadisar, QDistinct> {
  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByActivityDateDeadline(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityDateDeadline',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByActivityIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityIds');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByActivityUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activityUserId');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByCity(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'city', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByContactName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contactName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByCountryId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'countryId');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByCreateDate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createDate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByDateClosed(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateClosed', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByDayClose() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayClose');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByDayOpen() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dayOpen');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByEmailFrom(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'emailFrom', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByExpectedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedRevenue');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByLeadId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'leadId');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByPartnerAssignedId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerAssignedId');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByPartnerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'partnerId');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByPriority(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'priority', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByProbability() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'probability');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByProratedRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'proratedRevenue');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByRecurringRevenue() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenue');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct>
      distinctByRecurringRevenueMonthly() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueMonthly');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct>
      distinctByRecurringRevenueMonthlyProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueMonthlyProrated');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct>
      distinctByRecurringRevenueProrated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recurringRevenueProrated');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByStageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stageId');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByTagIds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagIds');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByTagNames(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tagNames', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamId');
    });
  }

  QueryBuilder<Leadisar, Leadisar, QDistinct> distinctByUserId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userId');
    });
  }
}

extension LeadisarQueryProperty
    on QueryBuilder<Leadisar, Leadisar, QQueryProperty> {
  QueryBuilder<Leadisar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations>
      activityDateDeadlineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityDateDeadline');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations> activityIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityIds');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations>
      activityUserIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activityUserId');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations> cityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'city');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations> contactNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contactName');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations> countryIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'countryId');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations> createDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createDate');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations> dateClosedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateClosed');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations> dayCloseProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayClose');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations> dayOpenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dayOpen');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations> emailFromProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'emailFrom');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations> expectedRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedRevenue');
    });
  }

  QueryBuilder<Leadisar, int?, QQueryOperations> leadIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'leadId');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations>
      partnerAssignedIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerAssignedId');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations> partnerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'partnerId');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations> priorityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'priority');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations> probabilityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'probability');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations> proratedRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'proratedRevenue');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations> recurringRevenueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenue');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations>
      recurringRevenueMonthlyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueMonthly');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations>
      recurringRevenueMonthlyProratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueMonthlyProrated');
    });
  }

  QueryBuilder<Leadisar, double?, QQueryOperations>
      recurringRevenueProratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recurringRevenueProrated');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations> stageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stageId');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations> tagIdsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagIds');
    });
  }

  QueryBuilder<Leadisar, String?, QQueryOperations> tagNamesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tagNames');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations> teamIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamId');
    });
  }

  QueryBuilder<Leadisar, List<int>?, QQueryOperations> userIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userId');
    });
  }
}
