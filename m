From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] can: m_can: Fix default pinmux glitch at init
Date: Sat, 21 Dec 2019 12:53:18 +0200
Message-ID: <be6bad41-4893-6e2c-4fab-411125ab5d94@ti.com>
References: <20191217100740.2687835-1-marex@denx.de>
 <8b2e0a40-cf23-58a5-4f52-215015c61ea8@ti.com>
 <3c48dd07-154e-bc47-4aff-73769d9efa22@denx.de>
 <be0d0b55-c287-3252-e188-cbaedd5d426c@ti.com>
 <b875d2a3-a39d-b00b-3558-96cab1e00165@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <b875d2a3-a39d-b00b-3558-96cab1e00165@denx.de>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: Bich Hemon <bich.hemon@st.com>, "J . D . Schroeder" <jay.schroeder@garmin.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Roger Quadros <rogerq@ti.com>, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org



On 19/12/2019 23:47, Marek Vasut wrote:
> On 12/19/19 2:37 PM, Grygorii Strashko wrote:
>>
>>
>> On 17/12/2019 12:55, Marek Vasut wrote:
>>> On 12/17/19 11:42 AM, Grygorii Strashko wrote:
>>>>
>>>>
>>>> On 17/12/2019 12:07, Marek Vasut wrote:
>>>>> The current code causes a slight glitch on the pinctrl settings when
>>>>> used.
>>>>> Since commit ab78029 (drivers/pinctrl: grab default handles from
>>>>> device core),
>>>>> the device core will automatically set the default pins. This causes
>>>>> the pins
>>>>> to be momentarily set to the default and then to the sleep state in
>>>>> register_m_can_dev(). By adding an optional "enable" state, boards can
>>>>> set the
>>>>> default pin state to be disabled and avoid the glitch when the switch
>>>>> from
>>>>> default to sleep first occurs. If the "enable" state is not available
>>>>> pinctrl_get_select() falls back to using the "default" pinctrl state.
>>>>>
>>>>> Fixes: c9b3bce18da4 ("can: m_can: select pinctrl state in each
>>>>> suspend/resume function")
>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>> Cc: Bich Hemon <bich.hemon@st.com>
>>>>> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
>>>>> Cc: J.D. Schroeder <jay.schroeder@garmin.com>
>>>>> Cc: Marc Kleine-Budde <mkl@pengutronix.de>
>>>>> Cc: Roger Quadros <rogerq@ti.com>
>>>>> Cc: linux-stable <stable@vger.kernel.org>
>>>>> To: linux-can@vger.kernel.org
>>>>> ---
>>>>> NOTE: This is commit 033365191136 ("can: c_can: Fix default pinmux
>>>>> glitch at init")
>>>>>          adapted for m_can driver.
>>>>> ---
>>>>>     drivers/net/can/m_can/m_can.c | 8 ++++++++
>>>>>     1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git a/drivers/net/can/m_can/m_can.c
>>>>> b/drivers/net/can/m_can/m_can.c
>>>>> index 02c5795b73936..afb6760b17427 100644
>>>>> --- a/drivers/net/can/m_can/m_can.c
>>>>> +++ b/drivers/net/can/m_can/m_can.c
>>>>> @@ -1243,12 +1243,20 @@ static void m_can_chip_config(struct
>>>>> net_device *dev)
>>>>>     static void m_can_start(struct net_device *dev)
>>>>>     {
>>>>>         struct m_can_classdev *cdev = netdev_priv(dev);
>>>>> +    struct pinctrl *p;
>>>>>           /* basic m_can configuration */
>>>>>         m_can_chip_config(dev);
>>>>>           cdev->can.state = CAN_STATE_ERROR_ACTIVE;
>>>>>     +    /* Attempt to use "active" if available else use "default" */
>>>>> +    p = pinctrl_get_select(cdev->dev, "active");
>>>>> +    if (!IS_ERR(p))
>>>>> +        pinctrl_put(p);
>>>>> +    else
>>>>> +        pinctrl_pm_select_default_state(cdev->dev);
>>>>> +
>>>>>         m_can_enable_all_interrupts(cdev);
>>>>>     }
>>>>>    
>>>>
>>>> May be init state should be used - #define PINCTRL_STATE_INIT "init"
>>>> instead?
>>>
>>> I'm not sure I quite understand -- how ?
>>>
>>
>> Sry, for delayed reply.
>>
>> I've looked at m_can code and think issue is a little bit deeper
>>   (but I might be wrong as i'm not can expert and below based on code
>> review).
>>
>> First, what going on:
>> probe:
>>   really_probe()
>>    pinctrl_bind_pins()
>>          if (IS_ERR(dev->pins->init_state)) {
>>          ret = pinctrl_select_state(dev->pins->p,
>>                         dev->pins->default_state);
>>      } else {
>>          ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
>>      }
>>    [GS] So at this point default_state or init_state is set
>>
>>    ret = dev->bus->probe(dev);
>>         m_can_plat_probe()
>>       m_can_class_register()
>>          m_can_clk_start()
>>            pm_runtime_get_sync()
>>          m_can_runtime_resume()
>>    [GS] Still default_state or init_state is active
>>
>>         register_m_can_dev()
>>    [GS] at this point m_can netdev is registered, which may lead to
>> .ndo_open = m_can_open() call
>>
>>           m_can_clk_stop()
>>             pm_runtime_put_sync()
>>    [GS] if .ndo_open() was called before it will be a nop
>>          m_can_runtime_suspend()
>>           m_can_class_suspend()
>>
>>              if (netif_running(ndev)) {
>>                  netif_stop_queue(ndev);
>>                  netif_device_detach(ndev);
>>                  m_can_stop(ndev);
>>                  m_can_clk_stop(cdev);
>>    [GS] if .ndo_open() was called before it will lead to deadlock here
>>        So, most probably, it will cause deadlock in case of "ifconfig
>> <m_can_dev> up down" case
>>              }
>>
>>              pinctrl_pm_select_sleep_state(dev);
>>    [GS] at this point sleep_state will be set - i assume it's the root
>> cause of your glitch.
>>         Note - As per code, the pinctrl default_state will never ever
>> configured again, so if after
>>         probe m_can will go through PM runtime suspend/resume cycle it
>> will not work any more.
>>
>>    pinctrl_init_done()
>>    [GS] will do nothing in case !init_state
>>
>> As per above, if sleep_state is defined the m_can seems should not work
>> at all without your patch,
>> as there is no code path to switch back sleep_state->default_state.
>> And over all PM runtime m_can code is mixed with System suspend code and
>> so not correct.
>>
>> Also, the very good question - Is it really required to toggle pinctrl
>> states as part of PM runtime?
>> (usually it's enough to handle it only during System suspend).
> 
> I suspect this discussion is somewhat a separate topic from what this
> patch is trying to fix ?
> 

Not exactly. The reason you need this patch is misuse of PM runtime vs pin control
in this driver. And this has to be fixed first of all.

I feel that just removing of m_can_class_suspend() call from m_can_runtime_suspend()
will fix things for you - it will toggle pin states only during Suspend to RAM cycle.


-- 
Best regards,
grygorii
