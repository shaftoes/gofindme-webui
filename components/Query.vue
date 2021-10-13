<template>
<div>
  <a-table :columns="columns" :data-source="this.data" :title="titlefn">
    <a slot="name" slot-scope="text">{{ text }} </a>
    <span slot="lastRan" slot-scope="last_ran">
      {{ last_ran }}
    </span>
    <span slot="dateCreated" slot-scope="date_created">
      {{ date_created }}
    </span>
    <span slot="tags" slot-scope="tags">
      <a-tag
        v-for="tag in tags"
        :key="tag"
        :color="tag === 'loser' ? 'volcano' : tag.length > 5 ? 'geekblue' : 'green'"
      >
        {{ tag.toUpperCase() }}
      </a-tag>
    </span>
    <span slot="action" slot-scope="text, record">
      <a-button v-if="record.enabled" type="danger">
        disable
      </a-button>
      <a-button v-else type="primary">
        enable
      </a-button>
        <!-- <a>Invite 一 {{ record.name }}</a> -->
      <!-- <a-divider type="vertical" />
      <a>Delete</a>
      <a-divider type="vertical" />
      <a class="ant-dropdown-link"> More actions <a-icon type="down" /> </a> -->
    </span>
  </a-table>
</div>
</template>
<script>
const columns = [
  {
    dataIndex: 'name',
    key: 'name',
    title: 'name',
  },
  {
    dataIndex: 'url',
    title: "url",
    key: "url",
  },
  {
    dataIndex: 'money_raised',
    title: "money raised",
    key: "money raised",
  },
];

export default {
  data() {
    return {
      data: [],
      columns,
    };
  },
  async fetch() {
    this.data = await fetch(
      'http://localhost:8000/searches'
    ).then(res => res.json())
  },
  methods: {
    convertDate(unix_timestamp) {
      const date = new Date(unix_timestamp * 1000);
      return date.toDateString;
    }
  },
};
</script>

