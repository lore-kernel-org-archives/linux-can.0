From: Mahesh.Maharjan-EXT@continental-corporation.com
Subject: ISOTP-implementation
Date: Fri, 21 Sep 2012 10:58:37 +0200
Message-ID: <OFA6F22965.64945A5F-ONC1257A80.00311F72-C1257A80.00314FED@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout03.rmx.de ([217.111.120.11]:46949 "EHLO mailout03.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932072Ab2IUJEp (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 21 Sep 2012 05:04:45 -0400
Received: from kdin01.retarus.de (kdin01.retarus.de [172.19.17.48] (may be forged))
	by mailout03.rmx.de (8.14.4/8.14.5/retarus.custom) with ESMTP id q8L8wfbL021962
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-can@vger.kernel.org>; Fri, 21 Sep 2012 10:58:42 +0200
Received: from FRHB101.fr.ge.conti.de ([213.68.116.88])
	by kdin01.retarus.de (8.14.5/8.14.2/retarus.custom) with ESMTP id q8L8weTH003295
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Fri, 21 Sep 2012 10:58:41 +0200
Received: from frhb101.auto.contiwan.com (FRHB101.fr.ge.conti.de [172.29.3.131])
	by FRHB101.fr.ge.conti.de (8.13.8/8.13.8) with ESMTP id q8L8wem2016335
	for <linux-can@vger.kernel.org>; Fri, 21 Sep 2012 10:58:40 +0200
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

