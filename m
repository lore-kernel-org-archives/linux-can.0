From: Mahesh.Maharjan-EXT@continental-corporation.com
Subject: using multiple buffer with mailbox
Date: Thu, 30 Aug 2012 14:26:15 +0200
Message-ID: <OFB15B28F3.46CFFEF5-ONC1257A6A.004361AB-C1257A6A.0044524C@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout64.rmx.de ([62.134.45.44]:39355 "EHLO mailout64.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324Ab2H3M0X (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Aug 2012 08:26:23 -0400
Received: from [10.64.70.32] (HELO kdin64.retarus.de)
  by mailout64.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 36870099 for linux-can@vger.kernel.org; Thu, 30 Aug 2012 14:26:20 +0200
Received: from sbas140a.vs.de.conti.de ([10.215.251.126])
	by kdin64.retarus.de (8.14.2/8.14.2/retarus.custom) with ESMTP id q7UCQIrr030793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Thu, 30 Aug 2012 14:26:19 +0200
Received: from sbas140a.cw01.contiwan.com (sbas140a.vs.de.conti.de [158.92.186.121])
	by sbas140a.vs.de.conti.de (8.13.8/8.13.8) with ESMTP id q7UCQIWd015315
	for <linux-can@vger.kernel.org>; Thu, 30 Aug 2012 14:26:18 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

hello to all Again,

 As I working with imx,  I want to know ,  How do SocketCAN can be 
implement with mailbox ( 64 message buffer) regarding flexcan flexibilti 
and hardware filters. Or is there possible to implement  along message 
buffer using priority based CAN message  using Socket CANin upperlayer , 
with CAN_buffer register Interrupts.

Another question , which interest me is ,CAN_ ISO TP implementaion , which 
 I check in linux-can, I could not find the sources & header files, but , 
CAN-util is using  CAN_ISOTP- examples.  Do, still ISO-TP in  test mode Or 
it is already beed implement.

~ Mahesh
