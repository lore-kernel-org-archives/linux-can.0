From: Damien Dusha <d.dusha@gmail.com>
Subject: Re: Dropped Tx frames with SJA1000
Date: Fri, 29 Jul 2016 10:35:04 +1000
Message-ID: <CABeNA8eE2NLRjQYimRG09Qouyfdbu6AUyHwRJD4sK3dr3q8pDw@mail.gmail.com>
References: <CABeNA8droHfwjaTkqnjbJBZTmETy_n58QDxFq9dne9w1EcjyHQ@mail.gmail.com>
 <111f48cb-d8e6-67fc-9644-389f342601cb@optusnet.com.au> <CABeNA8dX7GRTDO+1wgz3Wv9v-n4U5tnpHJUHi=V_G57PtXVyCQ@mail.gmail.com>
 <caed996e-2c8e-f54d-78ba-d69ab4361ae6@grandegger.com> <CABeNA8fh=kLpAYo49FLpxzQv-sBSBqWm1v_anbAkGA1sXAF-mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:33585 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbcG2AfG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 28 Jul 2016 20:35:06 -0400
Received: by mail-yw0-f179.google.com with SMTP id r9so102036077ywg.0
        for <linux-can@vger.kernel.org>; Thu, 28 Jul 2016 17:35:05 -0700 (PDT)
In-Reply-To: <CABeNA8fh=kLpAYo49FLpxzQv-sBSBqWm1v_anbAkGA1sXAF-mQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: tom_usenet@optusnet.com.au, linux-can@vger.kernel.org

Hello All,

>> I am attempting to debug an issue with the SJA1000 driver. The symptom
>> is the occasional dropped frame when transmitting a burst of frames.
>> Reception is unaffected.
>
> What does "ip -d -s link show can0" report?

Thanks to Wolfgang's hint, I have managed to find the problem.  The
clue comes from the command that was suggested. From this command, it
can be seen that the queue discipline (qdisc) used by default in
Fedora 24 is fq_codel.
can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc *fq_codel* state UNKNOWN

This is the problem; Wikipedia [1] makes it clear that the queuing
algorithm will drop packets from the queue in particular
circumstances, especially if it has been waiting too long.  If I
change the qdisc to pfifo, then transmit works perfectly:
sudo tc qdisc replace dev can0 root pfifo

Most other machines that I have access to - including Ubuntu 14.04 -
uses pfifo_fast as the qdisc.

This is certainly one to add to the "checklist" for debugging problems
like this.

Thanks again to everyone for their assistance.

Kind regards,
Damien.

[1] https://en.wikipedia.org/wiki/CoDel
