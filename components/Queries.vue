<template>
<div>
    <a-input-search placeholder="place search term here" size="large" @search="onSearch">
    <a-button slot="enterButton">
      add query
    </a-button>
  </a-input-search>
  <a-table :columns="columns" :data-source="this.data" :title="titlefn">
    <span slot="name" slot-scope="text, record" ><NuxtLink :to="'/query/' + record.id"> {{ text }} </NuxtLink> </span>
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
      <a-button v-on:click="export_csv(record.id)"> export </a-button>
    </span>
  </a-table>
</div>
</template>
<script>
const columns = [
  {
    dataIndex: 'query',
    key: 'name',
    title: 'Query',
    slots: { title: 'customTitle' },
    scopedSlots: { customRender: 'name' },
  },
  {
    dataIndex: 'num_urls',
    title: "Number of Urls",
    key: "num_urls",
  },
  {
    dataIndex: 'last_ran',
    title: "last ran",
    key: "last_ran",
    scopedSlots: { customRender: 'lastRan' },
  },
  {
    dataIndex: 'date_created',
    title: "Date Created",
    key: "date_Created",
    scopedSlots: { customRender: 'dateCreated' },
  },
  {
    title: 'Action',
    key: 'action',
    scopedSlots: { customRender: 'action' },
  },
];

export default {
  data() {
    return {
      data: [],
      columns,
      counter: 0,
      url: "asdf"
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
    },
    export_csv(id) {
      fetch('http://localhost:8000/export/' + id)
      .then(res => res.json())
      .then(res => {
        window.open(res.url)
      })
    },
    onSearch(value) {

    }
  },
};
</script>

