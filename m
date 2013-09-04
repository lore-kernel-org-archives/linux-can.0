From: Michael Muldoon <mbmuldoon07@gmail.com>
Subject: can acknowledgment
Date: Wed, 4 Sep 2013 15:47:38 -0400
Message-ID: <CAJU5jUJBe49CsixJcy292Qp0VruPJo+1_FSp3FxyNFxjZDJhLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36793 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755066Ab3IDTrj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Sep 2013 15:47:39 -0400
Received: by mail-wg0-f50.google.com with SMTP id j13so845395wgh.29
        for <linux-can@vger.kernel.org>; Wed, 04 Sep 2013 12:47:38 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

So I have a decent amount of experience with can but this is my first
time using it on a linux device and therefore my first experience with
socket-can.  Anyway the problem is that I am unable to view any can
messages on the network without two other can devices on it currently
a pcan from preak systems and an intrepid fire.  Also I'm unable to
send can messages.  Everything seems to be pointing to a can
acknowledgment issue which I have had experience with before but I
can't seems to figure out the root cause of it here.
