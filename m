From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: Request for proper hardware dependencies
Date: Tue, 6 May 2014 11:13:21 +0200
Message-ID: <21352.42929.159377.243822@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-box05.hrz.tu-darmstadt.de ([130.83.156.247]:40402 "EHLO
	lnx141.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934559AbaEFJxF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 May 2014 05:53:05 -0400
Received: from lnx503.hrz.tu-darmstadt.de (lnx503.hrz.tu-darmstadt.de [130.83.156.232])
	by lnx141.hrz.tu-darmstadt.de (8.14.4/8.13.8) with ESMTP id s469HYwT013940
	for <linux-can@vger.kernel.org>; Tue, 6 May 2014 11:17:34 +0200
	(envelope-from bon@elektron.ikp.physik.tu-darmstadt.de)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>

Hallo,

the number of kernel driver exploded in the last years and so the kernel
configuration. Distribution mantainers must at some point limit compiled
driver at least partly to the driver needed one on a given arch. However the
distribution maintainers mosty can't always know what they deal about.

For me this resulted in loosing socketcan from the Opensuse Kernels in
between 12.3 up to some weeks ago, as one maintainer (not Jean) matched
socketcan in error with "SPI" which is not related to normal desktop
machines. See
http://lists.opensuse.org/archive/opensuse-bugs/2014-01/msg00970.html.
Opensuse 13.1 recent kernels and the next release will have socketcan again,
but in the course of the discussion Jean Delvare pointed some weak points in
socketcan configuration, leading to compilation on driver not needed on some
archs:

>>>>> "Jean" == Jean Delvare <jdelvare@suse.com> writes:

    Jean> For the record, hardware dependencies on CAN device drivers aren't
    Jean> that bad in general, I've seen worse in several other subsystems.

    Jean> That being said, there is still some room for improvement. For
    Jean> example, CAN_AT91 could depend on ARCH_AT91 instead of just ARM,
    Jean> PCH_CAN could depend on X86, and a few drivers with "ISA" in their
    Jean> description should probably depend on ISA. I'm also not sure why
    Jean> CAN_MSCAN alternatively depends on M68K instead of just
    Jean> ARM. That's just from a quick look from the non-initiate I am,
    Jean> there may be more dependency fix-ups possible.  I'll send a few
    Jean> patches out if I can find some time for that today.

Please consider openly his patches or even better consider a cleanup yourself.

Bye
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
