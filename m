From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH] Add Travis-CI support
Date: Wed, 17 Jan 2018 16:15:24 +0100
Message-ID: <CAGm1_ksbGxOJO_9a5kR_51nyc3eGKP5j7o-hGz=r6qB0cWZpwA@mail.gmail.com>
References: <1516199605-28980-1-git-send-email-yegorslists@googlemail.com> <1221aaf3-b884-6467-90c6-cff7beacf58c@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33873 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753686AbeAQPPp (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 17 Jan 2018 10:15:45 -0500
Received: by mail-oi0-f68.google.com with SMTP id a70so13352884oib.1
        for <linux-can@vger.kernel.org>; Wed, 17 Jan 2018 07:15:45 -0800 (PST)
In-Reply-To: <1221aaf3-b884-6467-90c6-cff7beacf58c@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>

On Wed, Jan 17, 2018 at 3:57 PM, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 01/17/2018 03:33 PM, yegorslists@googlemail.com wrote:
>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> This configuration performs build tests for GCC and Clang
>> compilers.
>>
>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>
> Nice!
>
> For reasons we have non autotools based compilation, too. Can you use
> this one, too?
>
> It's just "make" without prior autogen.sh && configure

I'll add such a test.

>> ---
>>  .travis.yml | 24 ++++++++++++++++++++++++
>>  1 file changed, 24 insertions(+)
>>  create mode 100644 .travis.yml
>>
>> diff --git a/.travis.yml b/.travis.yml
>> new file mode 100644
>> index 0000000..0a7cfc4
>> --- /dev/null
>> +++ b/.travis.yml
>> @@ -0,0 +1,24 @@
>> +language: c
>> +
>> +matrix:
>> +    include:
>> +        - os: linux
>> +          dist: trusty
>> +          sudo: required
>> +          compiler: gcc
>> +        - os: linux
>> +          dist: trusty
>> +          sudo: required
>> +          compiler: clang
>> +
>> +addons:
>> +    apt:
>> +        packages:
>> +            - autoconf
>> +            - automake
>> +            - libtool
>> +            - m4
>> +        sources:
>> +            - ubuntu-toolchain-r-test
>> +
>> +script: ./autogen.sh && ./configure && make
>
> make distcheck

Do you mean:

script: ./autogen.sh && ./configure && make distcheck

Yegor
