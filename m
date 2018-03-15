From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2 1/1] can: ucan: add driver for Theobroma Systems UCAN
 devices
Date: Thu, 15 Mar 2018 07:58:35 +0100
Message-ID: <7f0bd797-64d4-ae96-00ae-5e11cf74d28e@grandegger.com>
References: <20180313173520.21257-1-jakob.unterwurzacher@theobroma-systems.com>
 <20180313173520.21257-2-jakob.unterwurzacher@theobroma-systems.com>
 <d7986f8f-6c52-bf39-93f0-7a837bd85241@grandegger.com>
 <03024ab7-5386-3bcf-76f2-ef2e0e9e7a78@theobroma-systems.com>
 <68564c40-396b-9081-8534-67fe96a6fb3f@grandegger.com>
 <92e559b1-d392-015e-1aa1-0497cbd4c071@grandegger.com>
 <5b3df9d5-3e65-1114-4b51-9dcc329cbc31@theobroma-systems.com>
 <b5bf52e2-0843-a2b3-b039-c39fb9c634e3@grandegger.com>
 <1bd41545-facb-9314-005b-4e742c4c61da@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1bd41545-facb-9314-005b-4e742c4c61da@theobroma-systems.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
Cc: Martin Elshuber <martin.elshuber@theobroma-systems.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



Am 14.03.2018 um 20:07 schrieb Jakob Unterwurzacher:
> On 14.03.18 11:04, Wolfgang Grandegger wrote:
>>>>  (000.000443)  can0  20000034   [8]  00 0C 00 00 00 00 78 00   
>>>> ERRORFRAME
>>>>     controller-problem{rx-error-warning,tx-error-warning}
>>>>     transceiver-status
>>>>     no-acknowledgement-on-tx
>>>>     error-counter-tx-rx{{120}{0}}
>>>>  (000.000444)  can0  20000034   [8]  00 3C 00 00 00 00 80 00   
>>>> ERRORFRAME
>>>>     
>>>> controller-problem{rx-error-warning,tx-error-warning,rx-error-passive,tx-error-passive} 
>>
>>
>> Just,
>>
>>        controller-problem{rx-error-passive,tx-error-passive} [...]
>>
>> Back to error active is missing!?
> 
> That was indeed missing. We have fixed the missing back-to-error-active 
> in our firmware.
> 
> Also, we no longer send the controller status in every error frame, but 
> only on state changes (see below) which seems to be how other drivers 
> are handling things.

Good, it would also be useful, if berr-reporting could be enabled by the 
firmware. This avoids a lot of traffic and load, especially if no cable 
is connected.

Wolfgang.
