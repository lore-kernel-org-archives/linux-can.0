From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: Can utils for CANFD
Date: Tue, 9 Feb 2016 10:18:02 +0000
Message-ID: <DA6901612C71B84D91459DE817C418AE26D8B38E@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-cys01nam02on0057.outbound.protection.outlook.com ([104.47.37.57]:63408
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756294AbcBILuv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Feb 2016 06:50:51 -0500
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
	by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
	(envelope-from <naga.sureshkumar.relli@xilinx.com>)
	id 1aT5Mz-0000xT-1i
	for linux-can@vger.kernel.org; Tue, 09 Feb 2016 02:18:05 -0800
Received: from [127.0.0.1] (helo=xsj-smtp-dlp2.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <naga.sureshkumar.relli@xilinx.com>)
	id 1aT5My-00068f-Tk
	for linux-can@vger.kernel.org; Tue, 09 Feb 2016 02:18:04 -0800
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
	by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id u19AI4BL027797
	for <linux-can@vger.kernel.org>; Tue, 9 Feb 2016 02:18:04 -0800
Received: from [172.22.159.25] (helo=XAP-PVEXCAS01.xlnx.xilinx.com)
	by xsj-pvapsmtp01 with esmtp (Exim 4.63)
	(envelope-from <nagasure@xilinx.com>)
	id 1aT5My-000680-0V
	for linux-can@vger.kernel.org; Tue, 09 Feb 2016 02:18:04 -0800
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Appana Durga Kedareswara Rao <appanad@xilinx.com>

Hi Marc,

I am adding Xilinx_canfd driver for Xilinx CANFD IP.
So to test that, I have downloaded https://github.com/linux-can/can-utils.

But it doesn't have canconfig option, to configure CANFD Controller. Like bitrate, mode etc...

It has only ip command support, but this ip utility doesn't have support to change can mode (Normal operation Mode).
It has only loopback mode support.

So, the can-utils, which I am using are the correct utils or not?

Suggest me, which one to use, to test CANFD.

Thanks,
Naga Sureshkumar Relli.


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

