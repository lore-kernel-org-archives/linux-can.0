From: Mahesh.Maharjan-EXT@continental-corporation.com
Subject: Loopback problem with Filters-ID
Date: Fri, 24 Aug 2012 09:28:18 +0200
Message-ID: <OF911BAA88.D6C43CE4-ONC1257A64.0028B9F0-C1257A64.00290B6B@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout64.rmx.de ([62.134.45.44]:48533 "EHLO mailout64.rmx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab2HXH22 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 24 Aug 2012 03:28:28 -0400
Received: from [10.64.70.33] (HELO kdin65.retarus.de)
  by mailout64.rmx.de (CommuniGate Pro SMTP 5.2.13 _community_)
  with ESMTP id 36714429 for linux-can@vger.kernel.org; Fri, 24 Aug 2012 09:28:25 +0200
Received: from sbas141a.vs.de.conti.de ([10.215.251.127])
	by kdin65.retarus.de (8.14.2/8.14.2/retarus.custom) with ESMTP id q7O7SNKm030232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-can@vger.kernel.org>; Fri, 24 Aug 2012 09:28:25 +0200
Received: from sbas141a.cw01.contiwan.com (sbas141a.vs.de.conti.de [158.92.186.140])
	by sbas141a.vs.de.conti.de (8.13.8/8.13.8) with ESMTP id q7O7SNTY019595
	for <linux-can@vger.kernel.org>; Fri, 24 Aug 2012 09:28:23 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello to all,
 Thanks for  all,

So it is better to use the Filter-Id for socket_RAW  to solve the problem 
arise by loopback...



