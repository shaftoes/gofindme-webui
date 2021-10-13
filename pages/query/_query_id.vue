<template>
<div>
  <Header />
  <div id="table-wrapper">
    <h1> campaigns for query {{ this.data.name }} </h1>
    <a-table :columns="columns" :data-source="this.data.campaigns" :title="titlefn" :pagination=false>
      <span slot="url" slot-scope="text, record">
        <a :href="record.url" target="_blank" rel="noreferrer noopener" > {{ record.url }} </a>
      </span>
    </a-table>
  </div>
</div>
</template>


<script>
import Vue from 'vue'

const columns = [
  {
    dataIndex: 'name',
    key: 'name',
    title: 'name',
  },
  {
    dataIndex: 'money_raised',
    title: "money_raised",
    key: "money_raised",
  },
  {
    dataIndex: 'goal',
    title: "goal",
    key: "goal",
  },
  {
    dataIndex: 'donors',
    title: "donors",
    key: "donors",
  },
  {
    dataIndex: 'shares',
    title: "shares",
    key: "shares",
  },
  {
    dataIndex: 'scraped_at',
    title: "Scraped At",
    key: "scraped_at",
  },
  {
    dataIndex: 'url',
    title: "url",
    key: "url",
    scopedSlots: { customRender: 'url' },
  },

];

export default Vue.extend({
  data() {
    return {
      data: [],
      columns,
    };
  },
  async fetch() {
    this.data = await fetch(
      'http://localhost:8000/search/1'
    ).then(res => res.json())
  },
  methods: {
    convertDate(unix_timestamp) {
      const date = new Date(unix_timestamp * 1000);
      return date.toDateString;
    }
  },
});
</script>


<style scoped>
#table-wrapper {
  margin-left: 20%;
  margin-right: 20%;
}

h1 {
  text-align: center;
}
</style>
