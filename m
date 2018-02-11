From: Daniel Santos <daniel.santos@pobox.com>
Subject: Framework for hardware filter support?
Date: Sat, 10 Feb 2018 20:38:15 -0600
Message-ID: <98bcd448-4d2a-bf2f-ae5a-4db7f1eac896@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63299 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeBKCiK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 10 Feb 2018 21:38:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39662D9070
        for <linux-can@vger.kernel.org>; Sat, 10 Feb 2018 21:38:10 -0500 (EST)
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B6E8D906F
        for <linux-can@vger.kernel.org>; Sat, 10 Feb 2018 21:38:10 -0500 (EST)
Received: from [192.168.1.4] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06F91D906E
        for <linux-can@vger.kernel.org>; Sat, 10 Feb 2018 21:38:08 -0500 (EST)
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>

Hello.=C2=A0 I'm doing a project where hardware filters will pretty much =
be
required unless we change the hardware.=C2=A0 I can just hack up the mcp2=
51x
driver and add some sysfs nodes to modify the filters, but it would be
much nicer to implement using some type of standard framework that I
could submit back upstream.

My current project uses an MCP2515 (with only two rx buffers) connected
via an MCP2210 USB-to-SPI bridge and that introduces a lot of latency
and interrupts may not be serviced for as much as 20-30 ms and w/o
hardware filters, we'll be missing a lot of messages we want to sniff.

I've read some of the arguments against it, such is it being a
multi-user environment.=C2=A0 To me that just means that hardware filters
should be configured at the interface level and not at the socket level.

So is there no such framework already in place?=C2=A0 If not, where would=
 be
the most logical place to add it? netfilter in the kernel and iproute2
in userland?

Thanks,
Daniel


