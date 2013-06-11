From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] flexcan: Use a regulator to control the CAN transceiver
Date: Mon, 10 Jun 2013 23:38:06 -0300
Message-ID: <CAOMZO5CtSZ-ru1PFdgBhtvNYMSfaqe=0Bnmk4sTLRzHROp1YEA@mail.gmail.com>
References: <1370460445-15386-1-git-send-email-festevam@gmail.com>
	<51B605E7.6080903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:36149 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752249Ab3FKCiI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 10 Jun 2013 22:38:08 -0400
Received: by mail-ve0-f178.google.com with SMTP id pb11so5317612veb.23
        for <linux-can@vger.kernel.org>; Mon, 10 Jun 2013 19:38:06 -0700 (PDT)
In-Reply-To: <51B605E7.6080903@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: shawn.guo@linaro.org, linux-can@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Marc,

On Mon, Jun 10, 2013 at 1:59 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
};
>> +
>> +             reg_can_3v3: can-3v3 {
>> +                     compatible = "regulator-fixed";
>> +                     regulator-name = "can-3v3";
>> +                     regulator-min-microvolt = <3300000>;
>> +                     regulator-max-microvolt = <3300000>;
>> +                     gpio = <&gpio2 13 0>;
>
> Can you convert GPIO2_13 from a hog gpio to a normal pinctl gpio?

I kept gpio2_13 as a hog gpio because on imx28-evk.dts we use this
approach for the fec and usb regulators.

Hope this is OK.
