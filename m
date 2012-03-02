From: Michael Economides <mecono@gmail.com>
Subject: read() question from newbie
Date: Fri, 2 Mar 2012 14:09:33 -0800
Message-ID: <CABHoAvmTvVfVKfwiZdf_=htKHYa554wpcPCRoEFujqwnxp9tkg@mail.gmail.com>
References: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.216.179]:61002 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757089Ab2CBWJe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 2 Mar 2012 17:09:34 -0500
Received: by qcha6 with SMTP id a6so887138qch.10
        for <linux-can@vger.kernel.org>; Fri, 02 Mar 2012 14:09:33 -0800 (PST)
In-Reply-To: <CABHoAvngDnUfh6w7NXQksrmeLq52_cRp809rFZ+HriwYpZqo9w@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

I am trying to use the cantest program to read.  It just blocks on the
read, and stays there forever.

 I can see on my scope there are can messages coming across the bus (from a
different microcontroller attached to the bus).

I have already verified I can write using cantest.

In other words, this works:  ./cantest can0 1F334455#1122334455667788

But this doesn't:  ./cantest can0

What could cause this?  Improper configuration is my suspicion.  Is it
possible these messages are being filtered somehow?  I am using MPC5121E
micro.

Any help would be appreciated.

Thanks,

--Mike
