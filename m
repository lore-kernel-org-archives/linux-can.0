From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: BCM ISSUE
Date: Tue, 22 Apr 2014 20:05:01 +0200
Message-ID: <5356AF4D.8030901@hartkopp.net>
References: <CADZ8cjnSH4oRR=VTgeva9rvyjbFmiT6QmP-yb5Es479_ZuOz+A@mail.gmail.com> <0AD3D310E3BB3A45B6040EDF5C9897721F50711E@VWAGWOXB0401.vw.vwg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:59342 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933564AbaDVSFE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Apr 2014 14:05:04 -0400
In-Reply-To: <0AD3D310E3BB3A45B6040EDF5C9897721F50711E@VWAGWOXB0401.vw.vwg>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: roccafrancesco@gmail.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Francesco,

> *Von:*Francesco Rocca [mailto:roccafrancesco@gmail.com]
> *Gesendet:* Samstag, 12. April 2014 18:53
> *Betreff:* BCM ISSUE
> 
 
> i'm starting to work with linux can; i saw you had got a important contribute
> for this library; so i think you are the right person can answer my question
> and solve my doubt.

It's not some kind of library but an application programmer interface to
access the CAN bus with BSD-style sockets.

See some overviews here:

http://events.linuxfoundation.org/sites/events/files/slides/elce2013-Kleine-Budde.pdf
http://www.can-cia.org/fileadmin/cia/files/icc/13/hartkopp.pdf

There's also a documentation in the Kernel Documents - including CAN_BCM:

https://www.kernel.org/doc/Documentation/networking/can.txt

> The BCM facility is interesting but i think i can't use it; i would like
> implement a data based filter;I would like only filter the frame on data
> content and not by can id. Is it possible? or do i have to use another
> approach?

The BCM can filter for data changes in the data section of the CAN frame.
It's a binary mask filter which is also described in can.txt.

There are some code examples in test applications, you can find in the
can-tests repository:

https://gitorious.org/linux-can/can-tests

https://gitorious.org/linux-can

Btw. you need to specify the CAN-ID when defining the content filter in the
CAN frames data section for the BCM. I assume filtering the content without
knowing the CAN-ID was not your real attempt, right?

Regards,
Oliver

ps. Sorry for the late answer - asking these kind of questions is better done
on the linux-can mailing list than sending it to my work mail account which
is not checked when I'm on vacancy :-)
  
