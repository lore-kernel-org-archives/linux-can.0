From: Austin Schuh <austin@peloton-tech.com>
Subject: CAN message timestamping
Date: Tue, 22 Mar 2016 22:12:13 -0700
Message-ID: <CANGgnMbLhYDdiK_tff0cEW+umuMOPN0h9x7t7cMK-xjMAMNBmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36452 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbcCWFMd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 23 Mar 2016 01:12:33 -0400
Received: by mail-yw0-f180.google.com with SMTP id g3so6041069ywa.3
        for <linux-can@vger.kernel.org>; Tue, 22 Mar 2016 22:12:33 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, Philipp Schrader <philipp@peloton-tech.com>

Hi,

We recently tried doing CAN timestamping with the ioctl(s, SIOCGSTAMP,
&tv) call.  It worked well, but all our timestamps internally are
based off the monotonic clock (since the realtime clock can jump and
go backwards in time.)  The conversion to the monotonic clock has been
tricky.  We already caught one bug today where it looks like our
simplistic sample both clocks and use that to compute the offset
algorithm was interrupted in the middle and resulted in the monotonic
time going backwards (which is wrong by definition).

Is there any way to get CAN timestamping with both clocks, or at least
with just the monotonic clock?  Or otherwise reliably get monotonic
time?

Thanks,
  Austin
