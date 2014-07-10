From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: skbuff panic
Date: Thu, 10 Jul 2014 10:37:38 -0700
Message-ID: <CANGgnMY4+PTnkd9CBUSS4EM6ZjP9r1wp8JYDJ4fYv+P1Qg6-vg@mail.gmail.com>
References: <CANGgnMbu511sgePeix3hjitO+xEazCw1j7Ya_81SA1GsN6W+QA@mail.gmail.com>
 <53B7D63B.2060108@hartkopp.net> <CANGgnMYu7DOWr5Zy934GkrGW=+FcaVKRCgZejMcugx0DCyN83A@mail.gmail.com>
 <53B8504C.4070808@hartkopp.net> <CANGgnMZHumyQNz3Z2ULYJWeNaqnbtenbSaL7gm=OwDjPnfdGcw@mail.gmail.com>
 <53B93D45.5090505@hartkopp.net> <53B97598.50400@hartkopp.net>
 <53B9A5AD.8050403@pengutronix.de> <CANGgnMZdKsB6WhorMMnLTNTB=rSq78ZEbMkH69x=FxGE_BXyCw@mail.gmail.com>
 <CANGgnMbb+2OodO7a4L5CSgn2wKTjwbu1tnZ8wAa=5RME_S_Nyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:49462 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaGJRh7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Jul 2014 13:37:59 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so869717igb.8
        for <linux-can@vger.kernel.org>; Thu, 10 Jul 2014 10:37:59 -0700 (PDT)
In-Reply-To: <CANGgnMbb+2OodO7a4L5CSgn2wKTjwbu1tnZ8wAa=5RME_S_Nyw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

On Wed, Jul 9, 2014 at 5:07 PM, Austin Schuh <austin@peloton-tech.com> wrote:
> With Oliver's patch, I'm able to get to 60 reboots and counting, so it
> looks like that was the problem.  I'll leave it rebooting over night
> to be sure.

The machine survived 216 reboots with no panics over the night.  Thanks Oliver!

Tested-by: Austin Schuh <austin@peloton-tech.com>
