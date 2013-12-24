From: Brennan Ashton <bashton@brennanashton.com>
Subject: Re: MCP251x bit rate calculations wrong
Date: Tue, 24 Dec 2013 12:08:59 -0800
Message-ID: <CANQdSEGmUVRmGFH6+mUxq8KTUWATVUDuT6CxaaHxsDQPe0=AeA@mail.gmail.com>
References: <CANQdSEGgf=UiYwKcOyoLA2qmtiF19XaD46_3ZkTHRUXOwe-+yQ@mail.gmail.com>
	<CANQdSEHbU1PfoLG4oOK+epKOp-pyn3n9E4xCsHJQMh5Y9znTng@mail.gmail.com>
	<526E214A.9090108@pengutronix.de>
	<CANQdSEHertsyR2Zbs7XrC9W3nqe=D5yQjKE=qJqC7q1wXZtVeQ@mail.gmail.com>
	<526E8B48.1090309@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:61200 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973Ab3LXUJA (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Dec 2013 15:09:00 -0500
Received: by mail-ve0-f175.google.com with SMTP id jx11so3594306veb.6
        for <linux-can@vger.kernel.org>; Tue, 24 Dec 2013 12:08:59 -0800 (PST)
In-Reply-To: <526E8B48.1090309@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On Mon, Oct 28, 2013 at 9:05 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 10/28/2013 04:50 PM, Brennan Ashton wrote:
>> On Mon, Oct 28, 2013 at 1:33 AM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>> On 10/26/2013 07:26 PM, Brennan Ashton wrote:
>>>> I did not see this line:
>>>> 1024 >---priv->can.clock.freq = pdata->oscillator_frequency / 2;$
>>>>
>>>> So the kernel driver should be fine but in can utils this should still
>>>> be fixed for the -1
>>>
>>> Can I add your Signed-off-by to the patch?
>>>
>>> Marc
>>
>> Sure,
>> Signed-off-by: Brennan Ashton <bashton@brennanashton.com>
>
> Pushed to master.
>
> tnx,
> Marc

This never seemed to have made it into the master branch.

--Brennan
