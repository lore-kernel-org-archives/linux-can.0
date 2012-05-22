From: Michael Economides <mecono@gmail.com>
Subject: certain CAN frames not being read ok
Date: Mon, 21 May 2012 17:37:07 -0700
Message-ID: <CABHoAvkZcMDi30MmYr+zYP=QTR_u5DxJ-5ib07L44KOQk8sVAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58697 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752657Ab2EVAhJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 21 May 2012 20:37:09 -0400
Received: by qcro28 with SMTP id o28so3632294qcr.19
        for <linux-can@vger.kernel.org>; Mon, 21 May 2012 17:37:08 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

I am reading CAN frames using read()

	nbytes = read(s, &rframe, sizeof(rframe));

Sometimes it works fine.  For example these frames are read ok:

123#44 33 33 33 33 33 33 44
112#05 01 01 01 22 22 33 33

However, this frame causes an "Ack slot" error:

123#01 00 00 00 00 00 00 00

Any ideas what could cause this?

I don't see why same ID but different data should cause a problem.

Thanks,

Mike
