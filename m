From: "D. Dueck" <davidcdueck@googlemail.com>
Subject: Re: [PATCH] can: at91_can: prepare and unprepare the clock
Date: Wed, 17 Sep 2014 12:11:38 +0200
Message-ID: <CANfhG651svVhhLch9ekjSESTgoS3-0rB1C9RJLkX_=Y=GKOxbA@mail.gmail.com>
References: <1410944721-32325-1-git-send-email-davidcdueck@googlemail.com>
	<54195097.1000106@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:55929 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbaIQKLk (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 17 Sep 2014 06:11:40 -0400
Received: by mail-la0-f44.google.com with SMTP id q1so353060lam.31
        for <linux-can@vger.kernel.org>; Wed, 17 Sep 2014 03:11:38 -0700 (PDT)
In-Reply-To: <54195097.1000106@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, wg@grandegger.com, nicolas.ferre@atmel.com, Anthony Harivel <anthony.harivel@emtrion.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

2014-09-17 11:12 GMT+02:00 Marc Kleine-Budde <mkl@pengutronix.de>:

> Which warning?

I will rephrase this. When using COMMON_CLK, for example on sama5d3, we
have to prepare the clock first. I will send v2.

> Can you please check the return value of clock_prepare_enbale().

Yes, sorry I missed that.

David
