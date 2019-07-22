
<input type="hidden" id="baseTree_parentId" name="baseTree.parentId"
	value="${o.baseTree.parentId}" />
<input type="hidden" id="baseTree_path" name="baseTree.path"
	value="${o.baseTree.path}" />
<input type="hidden" id="baseTree_pathName" name="baseTree.pathName"
	value="${o.baseTree.pathName}" />
<input type="hidden" id="baseTree_isLeaf" name="baseTree.isLeaf"
	value="${o.baseTree.isLeaf}" />

<script type="text/javascript">
<!--
	if ("${o.id}" == "" || "${o.id}" == "0"){
	    $ ("#baseTree_isLeaf").val (1);
    }
//-->
</script>