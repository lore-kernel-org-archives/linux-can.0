From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
Subject: peak_usb vs pcan
Date: Fri, 27 Apr 2012 12:02:59 +0200
Message-ID: <20378.28371.253927.472410@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lnx500.hrz.tu-darmstadt.de ([130.83.156.225]:55195 "EHLO
	lnx500.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760002Ab2D0KMi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Apr 2012 06:12:38 -0400
Received: from elektron.ikp.physik.tu-darmstadt.de (elektron.ikp.physik.tu-darmstadt.de [130.83.133.205])
	by lnx500.hrz.tu-darmstadt.de (8.14.4/8.14.4/HRZ/PMX) with ESMTP id q3RA2w43023739
	for <linux-can@vger.kernel.org>; Fri, 27 Apr 2012 12:02:58 +0200
	(envelope-from bon@elektron.ikp.physik.tu-darmstadt.de)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

I very much appreciate the in-source peak socketcan drivers versus the
out-of-source peak-linux-driver-xxx. No need for extra compile!

However the release note of peak-linux-driver-7.5 say among other things:
 * Blacklisted the peak_xxx mainline drivers

Can people help extend this list of pro/cons for the out-of source driver
 + Easy acquisition of status via /proc/pcan
 - Needs extra compilation when booting new kernel

Trying to follow the recent "Peak PCAN USB question" I still have no clear
view about can_get_berr_counter() and can_get_state().

Thanks
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
