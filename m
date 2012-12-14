From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: usb_8dev: USB Protocoll available?
Date: Fri, 14 Dec 2012 17:52:47 +0100
Message-ID: <20683.22879.172661.430971@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lnx141.hrz.tu-darmstadt.de ([130.83.156.236]:51407 "EHLO
	lnx141.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756224Ab2LNRaL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 14 Dec 2012 12:30:11 -0500
Received: from lnx500.hrz.tu-darmstadt.de (lnx500.hrz.tu-darmstadt.de [130.83.156.225])
	by lnx141.hrz.tu-darmstadt.de (8.14.4/8.13.8) with ESMTP id qBEGrn7g030725
	for <linux-can@vger.kernel.org>; Fri, 14 Dec 2012 17:53:49 +0100
	(envelope-from bon@elektron.ikp.physik.tu-darmstadt.de)
Received: from elektron.ikp.physik.tu-darmstadt.de (elektron.ikp.physik.tu-darmstadt.de [130.83.133.205])
	by lnx500.hrz.tu-darmstadt.de (8.14.4/8.14.4/HRZ/PMX) with ESMTP id qBEGr4BE032080
	for <linux-can@vger.kernel.org>; Fri, 14 Dec 2012 17:53:04 +0100
	(envelope-from bon@elektron.ikp.physik.tu-darmstadt.de)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org


Hello,

is there some document describing the protocoll used for the usb_8dev? I
have STM32 hardware with USB and CAN connected and think about writing some
firmware compatible with some existing adapter.

Otherwise, are the github projects

saeugetier / usb2can

shackspace / usb2can

for usb to can hardware related to this driver??

Thanks
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
