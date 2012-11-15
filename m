From: Steffen Rose <ro@emtas.de>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 15 Nov 2012 13:35:31 +0100
Message-ID: <14870489.3crZoRWJoA@lisa>
References: <loom.20121114T160521-534@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:58045 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993430Ab2KOMfe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 15 Nov 2012 07:35:34 -0500
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 81623563DD0
	for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 13:35:36 +0100 (CET)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qEseKbk9P0wa for <linux-can@vger.kernel.org>;
	Thu, 15 Nov 2012 13:35:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 26827563DD3
	for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 13:35:36 +0100 (CET)
Received: from lisa.localnet (lisa.emtas.de [192.168.3.54])
	by kolab.emtas.de (Postfix) with ESMTPS id E282A563DD0
	for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 13:35:35 +0100 (CET)
In-Reply-To: <loom.20121114T160521-534@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> I am encountering a serious issue where, at random intervals, the CAN
> interface will lock up and stop transmitting data.  Data reception
> continues normally. 

Hello,

the situation is like my described situation at the 8.10.
"unsure - socketCAN blocking"

socketCAN with EMS-USB interface
3.2.0-32-generic 64bit
running in a virtualBox
ip link add dev can0 type can

sometimes:
Transmission stop
Reception is working

-- 
Steffen Rose

