From: Mahesh.Maharjan-EXT@continental-corporation.com
Subject: ISOTP- implementation
Date: Fri, 21 Sep 2012 10:42:50 +0200
Message-ID: <OF26CC4F36.7636CEA3-ONC1257A80.002FA54A-C1257A80.002FDDFB@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout04.rmx.de ([94.199.90.94]:51460 "EHLO mailout04.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932070Ab2IUJCU (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Sep 2012 05:02:20 -0400
Received: from kdin02.retarus.de (kdin02.retarus.de [172.19.17.49] (may be forged))
	by mailout04.rmx.de (8.14.4/8.14.5/retarus.custom) with ESMTP id q8L8gxVL004554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-can@vger.kernel.org>; Fri, 21 Sep 2012 10:42:59 +0200
Received: from FRHB102.fr.ge.conti.de ([213.68.116.89])
	by kdin02.retarus.de (8.14.5/8.14.2/retarus.custom) with ESMTP id q8L8grPd013342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Fri, 21 Sep 2012 10:42:54 +0200
Received: from frhb102.auto.contiwan.com (FRHB102.fr.ge.conti.de [172.29.4.104])
	by FRHB102.fr.ge.conti.de (8.13.8/8.13.8) with ESMTP id q8L8gqpL010597
	for <linux-can@vger.kernel.org>; Fri, 21 Sep 2012 10:42:53 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

hello

In socketCan implementation with ISOTP_can, I want to know few things. As 
far. ISOTP is point to point. But , as in BCM and RAW, Is it possible to 
create multiple sockets for ISO-TP ??
Or creating each socket with Message object for reading and writing

Now If I want to implement with ISOTP with InterProcess Com  system  !! . 
which might have multiple PDU.. Suppose , In receiving side , I might have 
single master PDU and multi Slave PDU .. So  what could be idea.. if I 
want to use Socketcan ISO-TP standard Socketcan. and  I check in isotp.c 
file., But could able to figure out , how it realize with Socket and 
ISO-TP standard.
regards,
Mahesh
