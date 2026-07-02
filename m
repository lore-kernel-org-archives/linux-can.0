Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE632DC78C
	for <linux-can@vger.kernel.org>; Thu,  2 Jul 2026 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010050; cv=none; b=QIcqXB5BfqaNYiQtna00FeGuffVVOjfX28iwe1v57tADxSuiMH9f2mUP/hH0ppOBmA1ZDYCRHPqPCoa5SaqC6nvsRRmLPT+QnWhbN7ZO8HUmzlYp6jWy9UCDipMIE6gRToEsyh13gUCnCaPryOy0RD8yRq3dUpjO+qUkz8KM0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010050; c=relaxed/simple;
	bh=wtyPvfOPlI8lO1gtfdlkwshrP9wEL3DjzSaTi1Z0qJQ=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=u+45izsfKlOqyOAuAGD9gxiWgaHO2/EEZFSNfzbHWKnBlH5Dvh3wuklWm/XG5aY0iaQ3cS7JFW29qE2E+RrENqhf63DQOT1x33hQxrQy3zCl9lFg/DwB+iVvYvUJLYMnJgBXdTImHxWOYJCfGYst6UCise5ULMQPs1NFw29ou6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=g+9stt4p; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="g+9stt4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1783010047; bh=wtyPvfOPlI8lO1gtfdlkwshrP9wEL3DjzSaTi1Z0qJQ=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=g+9stt4pnAHDdShk48bm36MMxwtwtZHvlAwU3dgHxsbu99DTclqOh2GQVSNQrprYL
	 OU5INItRuox5iGeFBypkFu7jK/alEzViEbj8/UfzajmzSzPkQP4qndmVdazqviPaW1
	 OJuhonSS3EGKafHn3aUNCOI1ozWVRtisLWC12/pk=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: M3xhvUMF/amdXfLAcLPJYyxU8pfHztMec5KSMY0vwJQUUn1vgibdDU5f/p7kBy
	 osVo1Iz4SatIArLqt4V66CRmQQnG5gDWDRWyZZu/8Xh2ono92AqV+D4UZxraLFo1Y3EkUYjC7oWCf
	 RtY92rmqVasLgX3+2LWdu+59jZdbBi1qBfEe+MnKyncCfCmke9yM238yQJ+Rvfy9OaUZRDR6yEIze
	 eyzQpvxI66bzg3eErwrNs1WdEBrMhmIpskMKLBrLc+scf/sLmh5tjxUCKj6e4578zr6Mzrrlcmeqw
	 X+1YjBb/uvpwdDOL0UxcDGP5t57Us2otG5e/6g063KVnZCjPe77aq+cDL8UEqwZ2+6evoQgzhi22/
	 tS5luHM095Yi32d0tqNsXIU//PhyHDAK0KUJEbELnYTDw+4PtytWoWs5zkx7c02o+sYyHsc9oeWpi
	 VWgATXOCWDJQfDWDBnlREekcSoAg5u2nqAJ+Zs0e4hw1kZLBp5R2Svqe5tKfH4pDYdrqIHfZSuDuS
	 ZmJ58/cP2uCWT5R3phZr81iQ+sxoCvHjqx2m1XZv4KkSl6x5/yTwVT4BsQgCDsVt6MPGuQfRamSBi
	 FKu93BPG3KzSaVmkiesI5LcdjoSy+W5d7s6tisjfLLBObL714jXKEup+4qQlq1O7jeMfOP/TtxGvm
	 S0s+7oIyGkNespBfVx2o3DoOlYZk9ii4WZzgoiAJN7LqJ3A+csHMt+db7q7yRCMarKth9S8IQB8Ud
	 VdZ2emEQ3lWZFrWpP2AGAIFxilVRJ/97h0t7AUhR1qRvPB7jzhrBTAduaCEUMUYZz3s9iTSu8Riho
	 hP4+zJljgq5qA2ETivjUb1RHO1IpcO5lRTacTJm4gruidFmqujhcSPdmQ9Ff1f/S6itu2QpUV27rJ
	 4SwjkOAmx3hjMM3ZQ4ZXq2y7wgzFzW9mVrLTSznOkxR8IU8tHwrkqtxdvceMM+Lx267sKVGsg/b24
	 EJThpatMn2YyXrrhqysIfVG8jSR//llZJmOmlKtWqL0FoTdcdxi0BN1af8HdVHf12BhGAAlCDXTed
	 1H+zkTjspQDY9JLIgW98QNCW8aGdwvPHKFsFBrkstpMUKG7fdMdk2GVbL1eQA6j+Wy218LNsaD7Oq
	 ui8ht9cZHdr902M9qwKJrMphMWl+YFs5QsOTuh+bIhejQUndr6ZpuK72FHTWYFIZMHc=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?SGVpa28gU3TDvGJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>
Cc: "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?Um9iIEhlcnJpbmc=?=" <robh@kernel.org>, "=?utf-8?B?S3J6eXN6dG9mIEtvemxvd3NraQ==?=" <krzk+dt@kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?Q29ub3IgRG9vbGV5?=" <conor+dt@kernel.org>, "=?utf-8?B?RG1pdHJ5IFRvcm9raG92?=" <dmitry.torokhov@gmail.com>, "=?utf-8?B?U2hlbmdqaXUgV2FuZw==?=" <shengjiu.wang@nxp.com>, "=?utf-8?B?UGVuZ3BlbmcgSG91?=" <pengpeng@iscas.ac.cn>, "=?utf-8?B?UnVzc2VsbCBLaW5n?=" <rmk+kernel@armlinux.org.uk>, "=?utf-8?B?RXJpYyBCaWdnZXJz?=" <ebiggers@kernel.org>, "=?utf-8?B?TWFyaW8gTGltb25jaWVsbG8=?=" <mario.limonciello@amd.com>, "=?utf-8?B?S2FybCBNZWhsdHJldHRlcg==?=" <kmehltretter@gmail.com>, "=?utf-8?B?WWl4dW4gTGFu?=" <dlan@kernel.org>, "=?utf-8?B?U3RlcGhlbiBCb3lk?=" <sboyd@kernel.org>, 
	"=?utf-8?B?ZGV2aWNldHJlZQ==?=" <devicetree@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko.stuebner@cherry.de>
Subject: Re: [PATCH v2 2/4] can: rockchip: add RK3588 CAN support
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 3 Jul 2026 00:34:04 +0800
X-Priority: 3
Message-ID: <tencent_8BE421601F31C26FB9E99FA6440629016D05@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20260702140654.2961561-1-1579567540@qq.com>
 <tencent_F077D309CDB6CC4802CC086D8009E29BDF06@qq.com>
	<3527453.usfYGdeWWP@diego>
In-Reply-To: <3527453.usfYGdeWWP@diego>
X-QQ-mid: xmsezb41-0t1783010044trbhz8vjr

PiBJwqB0aGlua8KgeW91wqBtaWdodMKgd2FudMKgdG/CoGRyb3DCoHRoYXTCoGFib3ZlLsKg
SWbCoGFueXRoaW5nwqBhwqBDby1kZXZlbG9wZWQtYnkKPiB3b3VsZMKgYmXCoGFwcGxpY2Fi
bGUswqBidXTCoGZyb23CoHRoZcKgKHNtYWxsKcKgc2l6ZcKgb2bCoHRoZcKgY2hhbmdlLMKg
dGhhdMKgYWxzbwo+IGlzbid0wqByZWFsbHnCoG5lY2Vzc2FyecKgZm9ywqBtZcKgOi0pCj4K
Pgo+ID7CoFNpZ25lZC1vZmYtYnk6wqBDdW5oYW/CoEx1wqA8MTU3OTU2NzU0MEBxcS5jb20+
Cj4KPiBUZXN0ZWQtYnk6wqBIZWlrb8KgU3R1ZWJuZXLCoDxoZWlrb0BzbnRlY2guZGU+Cj4g
UmV2aWV3ZWQtYnk6wqBIZWlrb8KgU3R1ZWJuZXLCoDxoZWlrb0BzbnRlY2guZGU+CgpIaSBI
ZWlrbywKClNvcnJ5IGFib3V0IHRoYXQuIFRoaXMgaXMgbXkgZmlyc3QgY29udHJpYnV0aW9u
IHRvIHRoZSBMaW51eCBrZXJuZWwsIGFuZApJIGhhdmUgbm90IGZ1bGx5IHVuZGVyc3Rvb2Qg
eWV0IHdoaWNoIHRhZ3MgYXJlIGFwcHJvcHJpYXRlIGluIHdoaWNoCnNpdHVhdGlvbnMuIFBs
ZWFzZSBiZWFyIHdpdGggbWUuCgpJIHdpbGwgYWRkIHlvdXIgQ28tZGV2ZWxvcGVkLWJ5IHRh
ZyBpbiB2MywgdG9nZXRoZXIgd2l0aCB5b3VyClNpZ25lZC1vZmYtYnkgYXMgcmVxdWlyZWQg
Zm9yIENvLWRldmVsb3BlZC1ieS4KCkJlc3QgcmVnYXJkcywKQ3VuaGFvCgoKCgo=

