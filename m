From: Michael Economides <mecono@gmail.com>
Subject: changing bit timings from C program
Date: Tue, 8 May 2012 14:18:18 -0700
Message-ID: <CABHoAv=Q70Uegejcapk=ntFitR6--XaS05Wubsm4FTwZeCZ0dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50969 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754347Ab2EHVST (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 May 2012 17:18:19 -0400
Received: by qcro28 with SMTP id o28so3147231qcr.19
        for <linux-can@vger.kernel.org>; Tue, 08 May 2012 14:18:18 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

In the socketCAN documentation it says we should use the netlink
interface (from the command line) to change can bit timings:

http://lxr.linux.no/linux+v3.1.1/Documentation/networking/can.txt#L742

But I would like to know if there is an API I can call directly from
my C program to do it.

Thanks,

Mike
