From: Mohamed HAMZAOUI <requinham@gmail.com>
Subject: Re: AW: Web GUI for can-utils (i.e. cangw, cansend, candump)
Date: Tue, 11 Jun 2013 10:54:21 +0100
Message-ID: <CABMxt4i7og5rCM82Ex-DziUBty9R-JRH_PN5v8qyqOjJ7o06OA@mail.gmail.com>
References: <zarafa.51b5ff24.7028.506b738f3f6d3b02@v14647.1blu.de>
	<51B61980.5060302@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:44033 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab3FKJyW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Jun 2013 05:54:22 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so7282001lbh.35
        for <linux-can@vger.kernel.org>; Tue, 11 Jun 2013 02:54:21 -0700 (PDT)
In-Reply-To: <51B61980.5060302@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>

Hi,

Good idea. I think we could use Qt to develop this on a GUI based
application which you can deploy on several architecture.
I worked on a strong tool for simulation analysis and automatic
validation of CAN/LIN networks and we developp all in C/C++/Qt.
For Web based Gui, I think that it's possible to develop a gsoap
webservice which you can consume with interface web and other type of
application.

Regards,
Mohamed

> I would suggest to start with kcd files instead of dbc files, which are Vector
> property.

I think dbc format is too more used than kcd and switch to this format
it's not possible for many reason

Regards,
Mohamed
