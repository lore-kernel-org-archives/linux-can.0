Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F7E314B6D;
	Fri, 17 Jul 2026 02:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784254466; cv=fail; b=d39NgSYA12wb09353D6mR3ra6N/P8ezPoNDt8iv707FBbkpbT9Lv2kCGOPchbQ+oSyhyTfw4v2pluD6DuAU8lxXSQ78r04Aj2aas1giqxieF4l/7GU/WWZZKNDKHs97B/ZM2IBLyeE3os0NBAE/ffo4VOSInCaO50dv9fcKQ+Pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784254466; c=relaxed/simple;
	bh=AwJglWFrCdFr5NJrBoCvBLocnAwxShEEi3qzyIYzZ30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E9Q9iJbGwv6J/zPTEgbO5id4RCq3v4zfOqPGPM4rpF7Jc5HgXMuK3LEB0EWVTVPTe4Lo5o2LrPFB4BsX/SmzLCTl5wqjWEhYhOow67fO+fif8e1t4qnJr8v9uAG4mfaGzs5xuZpxpJ34k7bo9rmPP8JmcOW0ZhvTuXRi/YjAPQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rtwKExXs; arc=fail smtp.client-ip=40.107.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rtwKExXs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EN7lll0nbzL7HhYVXvUj9A+/x0tsMdP1/K7pZQ0/f/rhLF33rnOXGQssAs+aN0+dQ6u0b5OuCXOdt6yaSqwCzl50aaZyPzB+idpctNe1q7eilVLCixl9c9K3O5/7gLm5PXyXkNcR0BA9iL8YBELnEYO2D1oYEVMor5zkcbCzfRnK3OD6pXiXKdADmFbZuGvTN+4aagrlZ3T59SoeNNVwV7iSqpalc4FKJkiKbGof+/dyM4zaAGFikzF+yLbUDfkgyWWogzg1+vAgZ4o+mT0nMwcVOTkEYaSC0u4NFAG+qxzzw1XEODIwduhj8d9YXbm+knzCIa0tqVzkmwnS3gDuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zO2D+Y3wiH+BxldobfoeAVOEeAvC/bzLWtUwTK5S0gs=;
 b=okVvUBgf+8B1hOGGzm35w6ITEzqtl74BZfuYe0aw8aCadVIObrenMXx16M5rDnlTvdfFQgU65Zp6N020uIGMqsSJ8Yu4m6AtUm3HtknR4coJk6vbxHU2Y2CLj+xm7Oc1t9UZk9noCJICvqggJSD5IbLad+/a6eICkQnpTZMnv6NKK8cbatQZyT+REJf5Ge+BIyPsbxgIAin9Nn67EbaTDAttRbZIXvTBq6SmCE0f1TCM5GSB8D0feZ3wWtbliXCOxqtIW9jeQ1ZVMoYiS4wsQStDwlsbTzBgnRr51l6O8NvDODHzdYIcxaOZnJLXu8Un4kKhg3BZ/SshxOZYHJ5zXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zO2D+Y3wiH+BxldobfoeAVOEeAvC/bzLWtUwTK5S0gs=;
 b=rtwKExXshi4Icqb13gsRqjnRmac8QU4ZMlVrnnJzIqWQ/VyMYbIa4ABbEJuPcMk5c31XAdqbMTMkJlXQ8l2oUS3/3/7Lbn+9VIGmXP8TvpsVAP5U7Lo8YKU1jBQ8m/z4GdRMyDT6sMRFRpmfuXfcsA0DqMZbgMJE/o6vL6Ktwik=
Received: from BYAPR21CA0020.namprd21.prod.outlook.com (2603:10b6:a03:114::30)
 by DM4PR12MB5817.namprd12.prod.outlook.com (2603:10b6:8:60::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 02:14:20 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::46) by BYAPR21CA0020.outlook.office365.com
 (2603:10b6:a03:114::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5 via Frontend Transport; Fri, 17
 Jul 2026 02:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 02:14:19 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 21:14:18 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 16 Jul 2026 21:14:15 -0500
From: Harini T <harini.t@amd.com>
To: <mkl@pengutronix.de>, <mailhol@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <michal.simek@amd.com>,
	<appana.durga.kedareswara.rao@amd.com>
CC: <linux-can@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] dt-bindings: can: xilinx_can: Document phys and update maintainer
Date: Fri, 17 Jul 2026 07:44:13 +0530
Message-ID: <20260717021415.2234865-1-harini.t@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|DM4PR12MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: 027c25b4-643d-49ee-8d0f-08dee3a91c3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	qu9FtrUzltv9OgofV67tlCa4T2+7q8bqReYQnZXr7ZISoJaHVRudCHYV0fPtSrfELR3D4OuzyrKsgCda67qvVHDpAgI76NZb0/9a4v4GM7yDE7Ycs1Nj+OI8qEh7Ijn5AXhaq0rMEW91m8A8Vl2nneFFWl4CeuS7JCJS+NJ5xfvc3m3ReYemDGhrUlhyrQ/eysAsI/9svsufHWda6Z2i5wshLakrM57xW066dnS3JGHW6XE62x3WTj1tobwNcAQoHiueK8E6Kn6375/SHlGOi7KSbxrSwmGO71witC9pJGkoavH5PxYY56KdbGeWk+kguMI8B+IAdgMqfdbCXlZlLRXcVGwDuUi2HTBeTt5Ntq7K9lBR5vjf3mz7IYoWtQdxm8OI2R+s9ulHyB6VsfHBM/cGpmLstxHYP93YQuTbmSwGkp8XBTT7UgsnxHZ6P1QNpNfLxc9MIETkrAjLrn4mDytFYMh9gsuF1hd4IRost47zcCCCKECSn0N8BN9J0Upj4zXozl8FBuppB+z9R9RsUp9X50SfnA1r/50/l3XS2dgPuuQagduFiUyHs2X9ujFc2kFA5uP+Zn089PyDNgDDhcp9oyHjO9mi8Ah8xK4u3WXOeablN0nSs7gvQN341LeVz0GKNxMDv7AJrE2xSIHaPzKzMNPLmMkaeb91D26wfB6oRSS/pbRTrc3h8Ri5BeUdC5AMLocIQba/QXX99GLeQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1CFJuiUShuitPp+RLktOeGwNWhQ6AjgV80Ll7J5KlfNzIeYb10nbgOtYseio/2fs+xN1p2eY3dy7uAiMqufZfE05Kzsf5rxfh7mjpCw1gZYogXZdqvGQK7NXmJqZ5uZEJqHdgBL380kPDu7ddKGSX5TP+xv+12V5jhKLnR63fAQCDK/T3HbHBaAoi9w/H4UNthcqf1e5NQg0FJxMDr4p+F8sPTEdy4f5MF84+GAarLi8eMijnRqHh2hDfJE92zt47FUZVoAM0JZzIE4u0w5kzUeUENLXflKi5JZa5+ixnt836nJGpyV5qjJExeiRfxotnwee9pjqdd3LyAJqU+y0dwCPFTGwQbACFWHN3ssv7jZEpNdi63VkTBARDIJZgW4yW4+YHES7z91DbGiTPwea1m5GYaKiVuxn4XwV9OJUvRKKI4hjVsoEjaie3gtaLnZ6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 02:14:19.4840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 027c25b4-643d-49ee-8d0f-08dee3a91c3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5817

The Xilinx CAN and CANFD controllers can be connected to an external
CAN transceiver on the board, described from the controller node via
the standard "phys" property. This binding-only series documents that
property and updates the Xilinx CAN driver maintainer.

Patch 1 replaces the maintainer of the Xilinx CAN driver in both the
MAINTAINERS entry and the binding's maintainers list.

Patch 2 documents the optional "phys" property (a single transceiver
PHY).

Harini T (2):
  MAINTAINERS: Replace maintainer for Xilinx CAN driver
  dt-bindings: can: xilinx_can: Document phys property

 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 5 ++++-
 MAINTAINERS                                               | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.34.1

