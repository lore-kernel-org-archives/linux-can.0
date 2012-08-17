From: Mahesh.Maharjan-EXT@continental-corporation.com
Subject: loopback  problem with BCM, RAW using,   Daniele Venzano
Date: Fri, 17 Aug 2012 12:58:10 +0200
Message-ID: <OF5F6ABAA1.C0168430-ONC1257A5D.003ADDEA-C1257A5D.003C4200@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout65.rmx.de ([62.134.45.45]:40906 "EHLO mailout65.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757812Ab2HQK6T (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 17 Aug 2012 06:58:19 -0400
Received: from [10.64.70.33] (HELO kdin65.retarus.de)
  by mailout65.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 36657759 for linux-can@vger.kernel.org; Fri, 17 Aug 2012 12:58:16 +0200
Received: from sbas141a.vs.de.conti.de ([10.215.251.127])
	by kdin65.retarus.de (8.14.2/8.14.2/retarus.custom) with ESMTP id q7HAwEl7022187
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Fri, 17 Aug 2012 12:58:15 +0200
Received: from sbas141a.cw01.contiwan.com (sbas141a.vs.de.conti.de [158.92.186.140])
	by sbas141a.vs.de.conti.de (8.13.8/8.13.8) with ESMTP id q7HAwEQ9018369
	for <linux-can@vger.kernel.org>; Fri, 17 Aug 2012 12:58:14 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

hello to all,
 
Thanks to Oliver.  Suggesting for using both RAW n' BCM together .

But As Already discussed by Daniele Venzano : The loopback problems  are 
occurring , When Sending can_message from BCM , RAW also  trying to read 
all message  dynamically. ( Suppose we don't need filter in system).And  I 
want to ignore all message  coming to same my node Again.  Even I used 
same  option  for setting "loopback mode"in raw socket.  But suggestion 
mention by Daniele. : can_send(skb, 1)  from bcm.c. Sound pretty simple. 
But doesn't look better to change directly from source code. Yeah , Even I 
changed for testing .. "no work done "....

Help  !!!


With Regards,

Mahesh Maharjan


