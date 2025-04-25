// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teamsModel.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSalesTeamIsarCollection on Isar {
  IsarCollection<SalesTeamIsar> get salesTeamIsars => this.collection();
}

const SalesTeamIsarSchema = CollectionSchema(
  name: r'SalesTeamIsar',
  id: -4090659581246852679,
  properties: {
    r'barGroupsJson': PropertySchema(
      id: 0,
      name: r'barGroupsJson',
      type: IsarType.string,
    ),
    r'dateRangesJson': PropertySchema(
      id: 1,
      name: r'dateRangesJson',
      type: IsarType.string,
    ),
    r'hasBarData': PropertySchema(
      id: 2,
      name: r'hasBarData',
      type: IsarType.bool,
    ),
    r'invoicedTarget': PropertySchema(
      id: 3,
      name: r'invoicedTarget',
      type: IsarType.double,
    ),
    r'invoicingCurrent': PropertySchema(
      id: 4,
      name: r'invoicingCurrent',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 5,
      name: r'name',
      type: IsarType.string,
    ),
    r'openOpportunities': PropertySchema(
      id: 6,
      name: r'openOpportunities',
      type: IsarType.long,
    ),
    r'openOpportunitiesAmount': PropertySchema(
      id: 7,
      name: r'openOpportunitiesAmount',
      type: IsarType.double,
    ),
    r'ordersToInvoice': PropertySchema(
      id: 8,
      name: r'ordersToInvoice',
      type: IsarType.long,
    ),
    r'overdueOpportunities': PropertySchema(
      id: 9,
      name: r'overdueOpportunities',
      type: IsarType.long,
    ),
    r'overdueOpportunitiesAmount': PropertySchema(
      id: 10,
      name: r'overdueOpportunitiesAmount',
      type: IsarType.double,
    ),
    r'quotationsAmount': PropertySchema(
      id: 11,
      name: r'quotationsAmount',
      type: IsarType.double,
    ),
    r'quotationsCount': PropertySchema(
      id: 12,
      name: r'quotationsCount',
      type: IsarType.long,
    ),
    r'teamId': PropertySchema(
      id: 13,
      name: r'teamId',
      type: IsarType.long,
    ),
    r'unassignedLeads': PropertySchema(
      id: 14,
      name: r'unassignedLeads',
      type: IsarType.long,
    ),
    r'weeklyOpportunityDataJson': PropertySchema(
      id: 15,
      name: r'weeklyOpportunityDataJson',
      type: IsarType.string,
    )
  },
  estimateSize: _salesTeamIsarEstimateSize,
  serialize: _salesTeamIsarSerialize,
  deserialize: _salesTeamIsarDeserialize,
  deserializeProp: _salesTeamIsarDeserializeProp,
  idName: r'id',
  indexes: {
    r'teamId': IndexSchema(
      id: 8894498918133773550,
      name: r'teamId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'teamId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _salesTeamIsarGetId,
  getLinks: _salesTeamIsarGetLinks,
  attach: _salesTeamIsarAttach,
  version: '3.1.0+1',
);

int _salesTeamIsarEstimateSize(
  SalesTeamIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.barGroupsJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.dateRangesJson;
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
    final value = object.weeklyOpportunityDataJson;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _salesTeamIsarSerialize(
  SalesTeamIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.barGroupsJson);
  writer.writeString(offsets[1], object.dateRangesJson);
  writer.writeBool(offsets[2], object.hasBarData);
  writer.writeDouble(offsets[3], object.invoicedTarget);
  writer.writeDouble(offsets[4], object.invoicingCurrent);
  writer.writeString(offsets[5], object.name);
  writer.writeLong(offsets[6], object.openOpportunities);
  writer.writeDouble(offsets[7], object.openOpportunitiesAmount);
  writer.writeLong(offsets[8], object.ordersToInvoice);
  writer.writeLong(offsets[9], object.overdueOpportunities);
  writer.writeDouble(offsets[10], object.overdueOpportunitiesAmount);
  writer.writeDouble(offsets[11], object.quotationsAmount);
  writer.writeLong(offsets[12], object.quotationsCount);
  writer.writeLong(offsets[13], object.teamId);
  writer.writeLong(offsets[14], object.unassignedLeads);
  writer.writeString(offsets[15], object.weeklyOpportunityDataJson);
}

SalesTeamIsar _salesTeamIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SalesTeamIsar();
  object.barGroupsJson = reader.readStringOrNull(offsets[0]);
  object.dateRangesJson = reader.readStringOrNull(offsets[1]);
  object.hasBarData = reader.readBoolOrNull(offsets[2]);
  object.id = id;
  object.invoicedTarget = reader.readDoubleOrNull(offsets[3]);
  object.invoicingCurrent = reader.readDoubleOrNull(offsets[4]);
  object.name = reader.readStringOrNull(offsets[5]);
  object.openOpportunities = reader.readLongOrNull(offsets[6]);
  object.openOpportunitiesAmount = reader.readDoubleOrNull(offsets[7]);
  object.ordersToInvoice = reader.readLongOrNull(offsets[8]);
  object.overdueOpportunities = reader.readLongOrNull(offsets[9]);
  object.overdueOpportunitiesAmount = reader.readDoubleOrNull(offsets[10]);
  object.quotationsAmount = reader.readDoubleOrNull(offsets[11]);
  object.quotationsCount = reader.readLongOrNull(offsets[12]);
  object.teamId = reader.readLongOrNull(offsets[13]);
  object.unassignedLeads = reader.readLongOrNull(offsets[14]);
  object.weeklyOpportunityDataJson = reader.readStringOrNull(offsets[15]);
  return object;
}

P _salesTeamIsarDeserializeProp<P>(
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
      return (reader.readBoolOrNull(offset)) as P;
    case 3:
      return (reader.readDoubleOrNull(offset)) as P;
    case 4:
      return (reader.readDoubleOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readLongOrNull(offset)) as P;
    case 10:
      return (reader.readDoubleOrNull(offset)) as P;
    case 11:
      return (reader.readDoubleOrNull(offset)) as P;
    case 12:
      return (reader.readLongOrNull(offset)) as P;
    case 13:
      return (reader.readLongOrNull(offset)) as P;
    case 14:
      return (reader.readLongOrNull(offset)) as P;
    case 15:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _salesTeamIsarGetId(SalesTeamIsar object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _salesTeamIsarGetLinks(SalesTeamIsar object) {
  return [];
}

void _salesTeamIsarAttach(
    IsarCollection<dynamic> col, Id id, SalesTeamIsar object) {
  object.id = id;
}

extension SalesTeamIsarQueryWhereSort
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QWhere> {
  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhere> anyTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'teamId'),
      );
    });
  }
}

extension SalesTeamIsarQueryWhere
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QWhereClause> {
  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> idBetween(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> teamIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'teamId',
        value: [null],
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause>
      teamIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'teamId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> teamIdEqualTo(
      int? teamId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'teamId',
        value: [teamId],
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause>
      teamIdNotEqualTo(int? teamId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamId',
              lower: [],
              upper: [teamId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamId',
              lower: [teamId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamId',
              lower: [teamId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'teamId',
              lower: [],
              upper: [teamId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause>
      teamIdGreaterThan(
    int? teamId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'teamId',
        lower: [teamId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> teamIdLessThan(
    int? teamId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'teamId',
        lower: [],
        upper: [teamId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterWhereClause> teamIdBetween(
    int? lowerTeamId,
    int? upperTeamId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'teamId',
        lower: [lowerTeamId],
        includeLower: includeLower,
        upper: [upperTeamId],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SalesTeamIsarQueryFilter
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QFilterCondition> {
  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barGroupsJson',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barGroupsJson',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barGroupsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barGroupsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barGroupsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barGroupsJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'barGroupsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'barGroupsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barGroupsJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barGroupsJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barGroupsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      barGroupsJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barGroupsJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateRangesJson',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateRangesJson',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateRangesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateRangesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateRangesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateRangesJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dateRangesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dateRangesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dateRangesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dateRangesJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateRangesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      dateRangesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dateRangesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      hasBarDataIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasBarData',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      hasBarDataIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasBarData',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      hasBarDataEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasBarData',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition> idBetween(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicedTargetIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'invoicedTarget',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicedTargetIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'invoicedTarget',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicedTargetEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoicedTarget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicedTargetGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoicedTarget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicedTargetLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoicedTarget',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicedTargetBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoicedTarget',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicingCurrentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'invoicingCurrent',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicingCurrentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'invoicingCurrent',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicingCurrentEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'invoicingCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicingCurrentGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'invoicingCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicingCurrentLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'invoicingCurrent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      invoicingCurrentBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'invoicingCurrent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameGreaterThan(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameLessThan(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameStartsWith(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameEndsWith(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition> nameMatches(
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'openOpportunities',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'openOpportunities',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openOpportunities',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openOpportunities',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openOpportunities',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openOpportunities',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'openOpportunitiesAmount',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'openOpportunitiesAmount',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesAmountEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openOpportunitiesAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesAmountGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openOpportunitiesAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesAmountLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openOpportunitiesAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      openOpportunitiesAmountBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openOpportunitiesAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      ordersToInvoiceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ordersToInvoice',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      ordersToInvoiceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ordersToInvoice',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      ordersToInvoiceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ordersToInvoice',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      ordersToInvoiceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ordersToInvoice',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      ordersToInvoiceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ordersToInvoice',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      ordersToInvoiceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ordersToInvoice',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'overdueOpportunities',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'overdueOpportunities',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overdueOpportunities',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overdueOpportunities',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overdueOpportunities',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overdueOpportunities',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'overdueOpportunitiesAmount',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'overdueOpportunitiesAmount',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesAmountEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'overdueOpportunitiesAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesAmountGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'overdueOpportunitiesAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesAmountLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'overdueOpportunitiesAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      overdueOpportunitiesAmountBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'overdueOpportunitiesAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsAmountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quotationsAmount',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsAmountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quotationsAmount',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsAmountEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quotationsAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsAmountGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quotationsAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsAmountLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quotationsAmount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsAmountBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quotationsAmount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsCountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quotationsCount',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsCountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quotationsCount',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsCountEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quotationsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsCountGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quotationsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsCountLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quotationsCount',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      quotationsCountBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quotationsCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      teamIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'teamId',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      teamIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'teamId',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      teamIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'teamId',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      teamIdGreaterThan(
    int? value, {
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      teamIdLessThan(
    int? value, {
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      teamIdBetween(
    int? lower,
    int? upper, {
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

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      unassignedLeadsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unassignedLeads',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      unassignedLeadsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unassignedLeads',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      unassignedLeadsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unassignedLeads',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      unassignedLeadsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unassignedLeads',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      unassignedLeadsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unassignedLeads',
        value: value,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      unassignedLeadsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unassignedLeads',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'weeklyOpportunityDataJson',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'weeklyOpportunityDataJson',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weeklyOpportunityDataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weeklyOpportunityDataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weeklyOpportunityDataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weeklyOpportunityDataJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'weeklyOpportunityDataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'weeklyOpportunityDataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'weeklyOpportunityDataJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'weeklyOpportunityDataJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weeklyOpportunityDataJson',
        value: '',
      ));
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterFilterCondition>
      weeklyOpportunityDataJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'weeklyOpportunityDataJson',
        value: '',
      ));
    });
  }
}

extension SalesTeamIsarQueryObject
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QFilterCondition> {}

extension SalesTeamIsarQueryLinks
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QFilterCondition> {}

extension SalesTeamIsarQuerySortBy
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QSortBy> {
  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByBarGroupsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barGroupsJson', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByBarGroupsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barGroupsJson', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByDateRangesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangesJson', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByDateRangesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangesJson', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> sortByHasBarData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasBarData', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByHasBarDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasBarData', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByInvoicedTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoicedTarget', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByInvoicedTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoicedTarget', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByInvoicingCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoicingCurrent', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByInvoicingCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoicingCurrent', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOpenOpportunities() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOpportunities', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOpenOpportunitiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOpportunities', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOpenOpportunitiesAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOpportunitiesAmount', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOpenOpportunitiesAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOpportunitiesAmount', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOrdersToInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ordersToInvoice', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOrdersToInvoiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ordersToInvoice', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOverdueOpportunities() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueOpportunities', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOverdueOpportunitiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueOpportunities', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOverdueOpportunitiesAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueOpportunitiesAmount', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByOverdueOpportunitiesAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueOpportunitiesAmount', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByQuotationsAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quotationsAmount', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByQuotationsAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quotationsAmount', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByQuotationsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quotationsCount', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByQuotationsCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quotationsCount', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> sortByTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamId', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> sortByTeamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamId', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByUnassignedLeads() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unassignedLeads', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByUnassignedLeadsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unassignedLeads', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByWeeklyOpportunityDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyOpportunityDataJson', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      sortByWeeklyOpportunityDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyOpportunityDataJson', Sort.desc);
    });
  }
}

extension SalesTeamIsarQuerySortThenBy
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QSortThenBy> {
  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByBarGroupsJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barGroupsJson', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByBarGroupsJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'barGroupsJson', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByDateRangesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangesJson', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByDateRangesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateRangesJson', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> thenByHasBarData() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasBarData', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByHasBarDataDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasBarData', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByInvoicedTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoicedTarget', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByInvoicedTargetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoicedTarget', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByInvoicingCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoicingCurrent', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByInvoicingCurrentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'invoicingCurrent', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOpenOpportunities() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOpportunities', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOpenOpportunitiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOpportunities', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOpenOpportunitiesAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOpportunitiesAmount', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOpenOpportunitiesAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openOpportunitiesAmount', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOrdersToInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ordersToInvoice', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOrdersToInvoiceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ordersToInvoice', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOverdueOpportunities() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueOpportunities', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOverdueOpportunitiesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueOpportunities', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOverdueOpportunitiesAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueOpportunitiesAmount', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByOverdueOpportunitiesAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'overdueOpportunitiesAmount', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByQuotationsAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quotationsAmount', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByQuotationsAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quotationsAmount', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByQuotationsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quotationsCount', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByQuotationsCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quotationsCount', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> thenByTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamId', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy> thenByTeamIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'teamId', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByUnassignedLeads() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unassignedLeads', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByUnassignedLeadsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unassignedLeads', Sort.desc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByWeeklyOpportunityDataJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyOpportunityDataJson', Sort.asc);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QAfterSortBy>
      thenByWeeklyOpportunityDataJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyOpportunityDataJson', Sort.desc);
    });
  }
}

extension SalesTeamIsarQueryWhereDistinct
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct> {
  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct> distinctByBarGroupsJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'barGroupsJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByDateRangesJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateRangesJson',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct> distinctByHasBarData() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasBarData');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByInvoicedTarget() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoicedTarget');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByInvoicingCurrent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'invoicingCurrent');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByOpenOpportunities() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openOpportunities');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByOpenOpportunitiesAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openOpportunitiesAmount');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByOrdersToInvoice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ordersToInvoice');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByOverdueOpportunities() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overdueOpportunities');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByOverdueOpportunitiesAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'overdueOpportunitiesAmount');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByQuotationsAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quotationsAmount');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByQuotationsCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quotationsCount');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct> distinctByTeamId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'teamId');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByUnassignedLeads() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unassignedLeads');
    });
  }

  QueryBuilder<SalesTeamIsar, SalesTeamIsar, QDistinct>
      distinctByWeeklyOpportunityDataJson({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weeklyOpportunityDataJson',
          caseSensitive: caseSensitive);
    });
  }
}

extension SalesTeamIsarQueryProperty
    on QueryBuilder<SalesTeamIsar, SalesTeamIsar, QQueryProperty> {
  QueryBuilder<SalesTeamIsar, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<SalesTeamIsar, String?, QQueryOperations>
      barGroupsJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'barGroupsJson');
    });
  }

  QueryBuilder<SalesTeamIsar, String?, QQueryOperations>
      dateRangesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateRangesJson');
    });
  }

  QueryBuilder<SalesTeamIsar, bool?, QQueryOperations> hasBarDataProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasBarData');
    });
  }

  QueryBuilder<SalesTeamIsar, double?, QQueryOperations>
      invoicedTargetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoicedTarget');
    });
  }

  QueryBuilder<SalesTeamIsar, double?, QQueryOperations>
      invoicingCurrentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'invoicingCurrent');
    });
  }

  QueryBuilder<SalesTeamIsar, String?, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<SalesTeamIsar, int?, QQueryOperations>
      openOpportunitiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openOpportunities');
    });
  }

  QueryBuilder<SalesTeamIsar, double?, QQueryOperations>
      openOpportunitiesAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openOpportunitiesAmount');
    });
  }

  QueryBuilder<SalesTeamIsar, int?, QQueryOperations>
      ordersToInvoiceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ordersToInvoice');
    });
  }

  QueryBuilder<SalesTeamIsar, int?, QQueryOperations>
      overdueOpportunitiesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overdueOpportunities');
    });
  }

  QueryBuilder<SalesTeamIsar, double?, QQueryOperations>
      overdueOpportunitiesAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'overdueOpportunitiesAmount');
    });
  }

  QueryBuilder<SalesTeamIsar, double?, QQueryOperations>
      quotationsAmountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quotationsAmount');
    });
  }

  QueryBuilder<SalesTeamIsar, int?, QQueryOperations>
      quotationsCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quotationsCount');
    });
  }

  QueryBuilder<SalesTeamIsar, int?, QQueryOperations> teamIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'teamId');
    });
  }

  QueryBuilder<SalesTeamIsar, int?, QQueryOperations>
      unassignedLeadsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unassignedLeads');
    });
  }

  QueryBuilder<SalesTeamIsar, String?, QQueryOperations>
      weeklyOpportunityDataJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weeklyOpportunityDataJson');
    });
  }
}
