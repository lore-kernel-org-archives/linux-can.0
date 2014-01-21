From: bon@elektron.ikp.physik.tu-darmstadt.de
Subject: Re: usb_8dev: firmware and windows library
Date: Tue, 21 Jan 2014 13:19:36 +0100
Message-ID: <21214.26072.886368.818659@gargle.gargle.HOWL>
References: <f5902be125a3dd5ead00d75e01a45fa5.squirrel@webmail.universalnet.at>
	<52DE5EEF.6080100@hartkopp.net>
	<52DE60C7.3050906@8devices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lnx141.hrz.tu-darmstadt.de ([130.83.156.236]:44393 "EHLO
	lnx141.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754402AbaAUMZf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 21 Jan 2014 07:25:35 -0500
Received: from lnx500.hrz.tu-darmstadt.de (lnx500.hrz.tu-darmstadt.de [130.83.156.225])
	by lnx141.hrz.tu-darmstadt.de (8.14.4/8.13.8) with ESMTP id s0LCKj9G019722
	for <linux-can@vger.kernel.org>; Tue, 21 Jan 2014 13:20:45 +0100
	(envelope-from bon@elektron.ikp.physik.tu-darmstadt.de)
In-Reply-To: <52DE60C7.3050906@8devices.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gediminas Simanskis <gediminas@8devices.com>
Cc: linux-can@vger.kernel.org

>>>>> "Gediminas" == Gediminas Simanskis <gediminas@8devices.com> writes:

    Gediminas> Hello, I have changed in v1.5 usb2can firmware only 2x
    Gediminas> endpoints (3 and 4) sizes from 25 bytes to 64 because was
    Gediminas> problem (USB RX cmd enpoint freezing) on some PC which use
    Gediminas> windows7 or windows8 64 bit versions and under USB3 ports.Now
    Gediminas> works correct.  On windows systems usb2can works old driver
    Gediminas> without any changes.

Gediminas,

https://github.com/krumboeck/usb2can_firmware has no Makefile(.am) or
CMakeLists.txt. Can you perhaps send me a build log so I could try to
create a build environment?

Thanks

-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
