From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: exclusive access to can interface
Date: Mon, 07 Jan 2013 17:52:28 +0100
Message-ID: <2412937.XVpYjfC7zz@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:33271 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754011Ab3AGQwe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Jan 2013 11:52:34 -0500
Received: from comm.systec-electronic.de (95-91-81-39-dynip.superkabel.de [95.91.81.39])
	by webbox1416.server-home.net (Postfix) with ESMTPA id CB76727A604
	for <linux-can@vger.kernel.org>; Mon,  7 Jan 2013 17:48:58 +0100 (CET)
Received: from ws-stein.localnet (unknown [192.168.10.63])
	by comm.systec-electronic.de (Postfix) with ESMTP id 3EADB97C275
	for <linux-can@vger.kernel.org>; Mon,  7 Jan 2013 17:52:32 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

is there a way to get exclusive (write) access to a CAN interface, so that only one bound socket can write CAN frames on the bus?

Best regards,
Alexander

