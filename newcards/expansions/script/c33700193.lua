--Heavenly Maid Sanae
function c33700193.initial_effect(c)
	--This card cannot be used as a material for a Summon of a non-"Heavenly Maid" Fusion/Synchro/Xyz/Link monster, also it cannot be tributed, unless for the Summon of a "Heavenly Maid" monster.
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetValue(function(e,c) return not c:IsSetCard(0x444) end)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetValue(function(e,c) if c==nil then return true end return not c:IsSetCard(0x444) end)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e5)
	local e6=e3:Clone()
	e6:SetCode(EFFECT_CANNOT_BE_LINK_MATERIAL)
	c:RegisterEffect(e6)
	--This card cannot be Set.
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_CANNOT_MSET)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_TURN_SET)
	c:RegisterEffect(e8)
	local e9=e7:Clone()
	e9:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e9:SetTarget(c33700193.sumlimit)
	c:RegisterEffect(e9)
	--This card cannot be changed to Defense Position, except with a card effect.
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	ea:SetCondition(function(e) return e:GetHandler():IsPosition(POS_FACEUP_ATTACK) end)
	c:RegisterEffect(ea)
	--Cannot be destroyed by Battle or other Card Effects.
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_SINGLE)
	eb:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	eb:SetValue(1)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	ec:SetValue(function(e,c) return c~=e:GetHandler() end)
	c:RegisterEffect(e)
	--On your 2nd Standby Phase after this card is Normal or Special Summoned, Destroy this card.
	local ed=Effect.CreateEffect(c)
	ed:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	ed:SetCode(EVENT_SUMMON_SUCCESS)
	ed:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	ed:SetOperation(c33700193.desreg)
	c:RegisterEffect(ed)
	local ee=ed:Clone()
	ee:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(ee)
	--If this card leaves the field: Special Summon a "Heavenly Maid Token" (Fairy/LIGHT/Level 6/ATK 3000/DEF 2800) with this effect: (below)
	local ef=Effect.CreateEffect(c)
	ef:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	ef:SetCode(EVENT_LEAVE_FIELD)
	ef:SetCondition(function(e,tp,eg,ep,ev,re,r,rp) return e:GetHandler():IsPreviousPosition(POS_FACEUP) end)
	ef:SetCategory(CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
	ef:SetTarget(c33700193.sptg)
	ef:SetOperation(c33700193.spop)
	c:RegisterEffect(ef)
end
function c33700193.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return bit.band(sumpos,POS_FACEDOWN)>0
end
function c33700193.desreg(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:SetTurnCounter(0)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_PHASE_START+PHASE_STANDBY)
	e0:SetCountLimit(1)
	e0:SetOperation(c33700193.ctop)
	Duel.RegisterEffect(e0,tp)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetDescription(1124)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	--e1:SetLabelObject(e0)
	e1:SetReset(RESET_EVENT+0x1ee0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN,2)
	e1:SetCondition(c33700193.descon)
	e1:SetOperation(c33700193.desop)
	c:RegisterEffect(e1)
	c:CreateEffectRelation(e0)
end
function c33700193.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	if not c:IsRelateToEffect(e) or ct>=2 then
		c:SetTurnCounter(0)
		e:Reset()
		return
	end
	if Duel.GetTurnPlayer()~=tp then return end
	ct=ct+1
	c:SetTurnCounter(ct)
end
function c33700193.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetTurnCounter()==2
end
function c33700193.desop(e,tp,eg,ep,ev,re,r,rp)
	--if e:GetHandler():IsRelateToEffect(e:GetLabelObject()) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	--end
end
function c33700193.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c33700193.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,33700213,0,0x4011,3000,2800,6,RACE_FAIRY,ATTRIBUTE_LIGHT) then return end
	local token=Duel.CreateToken(tp,33700213)
	--When this card is attacked, destroy the attacking monster after damage calculation.
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCardTarget(c33700193.condition)
	e1:SetOperation(c33700193.operation)
	e1:SetReset(RESET_EVENT+0xfe0000)
	c:RegisterEffect(e1)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
function c33700193.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==e:GetHandler()
end
function c33700193.operation(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsRelateToBattle() then return end
	Duel.Destroy(a,REASON_EFFECT)
end
