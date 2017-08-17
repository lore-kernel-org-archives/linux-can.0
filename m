From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: j1939: bind() and connect()
Date: Thu, 17 Aug 2017 10:28:27 +0200
Message-ID: <20170817082827.GA7870@airbook.vandijck-laurijssen.be>
References: <048c5290-6cd0-aaec-8a74-1f38cbeb9efe@pengutronix.de>
 <e2a14f73-9456-18c1-7e83-70d43e30cdf0@pengutronix.de>
 <20170815110116.4d12f4f3@erd980>
 <7164d44c-76f9-45f6-b5fa-c931f058163f@pengutronix.de>
 <20170815122453.3945bead@erd980>
 <20170816210831.GE32670@airbook.vandijck-laurijssen.be>
 <bc05b42e-a458-59ce-784c-9214345bbc51@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b01.edpnet.be ([212.71.1.221]:51291 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdHQIaQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 17 Aug 2017 04:30:16 -0400
Content-Disposition: inline
In-Reply-To: <bc05b42e-a458-59ce-784c-9214345bbc51@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Jander <david@protonic.nl>, linux-can <linux-can@vger.kernel.org>


> Let's conclude:
> - bind() to any not allowed
> - bind() to a single interface needed before {send,rcv}_msg()
> - re-bind() to same interface allowed
> - bind() before connect() mandatory
4x ack

> - re-connect() allowed

As David pointed out, re-connect() is not necessary. If it makes things
much simpler, then drop it for now. right?

> 
> Is this correct?
> 
> regards.
> Marc

