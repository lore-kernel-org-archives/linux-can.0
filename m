From: Mahesh.Maharjan-EXT@continental-corporation.com
Subject: problem with adding socketcan isotp " frreescale imx"
Date: Mon, 10 Sep 2012 10:20:51 +0200
Message-ID: <OF888EFFE9.4D2BD1DC-ONC1257A75.002CF71F-C1257A75.002DDB22@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout65.rmx.de ([62.134.45.45]:55990 "EHLO mailout65.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345Ab2IJIVA (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 10 Sep 2012 04:21:00 -0400
Received: from [10.64.70.33] (HELO kdin65.retarus.de)
  by mailout65.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 37220676 for linux-can@vger.kernel.org; Mon, 10 Sep 2012 10:20:57 +0200
Received: from sbas141a.vs.de.conti.de ([10.215.251.127])
	by kdin65.retarus.de (8.14.2/8.14.2/retarus.custom) with ESMTP id q8A8Ktax004132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Mon, 10 Sep 2012 10:20:57 +0200
Received: from sbas141a.cw01.contiwan.com (sbas141a.vs.de.conti.de [158.92.186.140])
	by sbas141a.vs.de.conti.de (8.13.8/8.13.8) with ESMTP id q8A8KtTZ017636
	for <linux-can@vger.kernel.org>; Mon, 10 Sep 2012 10:20:55 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,
 I am trying to use SocketCAN  ISOTP in freescale imx board. I added isotp 
source file in freescale BSP (linux 2,638 imx ). It compile properly , but 
when I trying use in application it is not supported. As socket and 
binding with isotp is not with  working with it.

Any idea. ?? How can  I integrate with isotp , so  further process??

Thanks



