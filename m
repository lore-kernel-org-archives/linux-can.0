From: Matthias Klein <matthias.klein@optimeas.de>
Subject: can: flexcan: problems with bus error reporting om i.MX53
Date: Fri, 25 Jul 2014 20:16:34 +0200
Message-ID: <53D29F02.8010708@optimeas.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from obi-wan.optimeas.de ([82.165.198.204]:60849 "EHLO
	obi-wan.optimeas.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbaGYSYF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 14:24:05 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org, support@karo-electronics.de
Cc: Sebastian Siewior <bigeasy@linutronix.de>

Hi all,

we had the following problems when we enabled bus error reporting on an 
i.MX537 (Ka-Ro TX53-8130):
- interrupt flooding when sending a packet on an open bus
- bus state change notifications did not work properly
- second bus state change after bus recovery was not properly notified

The patches in the next mails fix all these problems and are tested 
against mainline linux 3.12.24-rt38 with PREEMPT_RT patch.

Best regards,
Matthias Klein

